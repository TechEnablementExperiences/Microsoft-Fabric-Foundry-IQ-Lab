# Databricks PowerShell Helper Functions
    function RefreshTokens() {
        # Copy external blob content
        $global:powerbitoken = ((az account get-access-token --resource https://analysis.windows.net/powerbi/api) | ConvertFrom-Json).accessToken
        $global:managementToken = ((az account get-access-token --resource https://management.azure.com) | ConvertFrom-Json).accessToken
        $global:fabric = ((az account get-access-token --resource https://api.fabric.microsoft.com) | ConvertFrom-Json).accessToken
        $global:graphToken = ((az account get-access-token --resource https://graph.microsoft.com) | ConvertFrom-Json).accessToken
    }

    function Check-HttpRedirect($uri) {
        $httpReq = [system.net.HttpWebRequest]::Create($uri)
        $httpReq.Accept = "text/html, application/xhtml+xml, */*"
        $httpReq.method = "GET"
        $httpReq.AllowAutoRedirect = $false;

        # use them all...
        # [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls11 -bor [System.Net.SecurityProtocolType]::Tls12 -bor [System.Net.SecurityProtocolType]::Ssl3 -bor [System.Net.SecurityProtocolType]::Tls;

        $global:httpCode = -1;
        $response = "";

        try {
            $res = $httpReq.GetResponse();

            $statusCode = $res.StatusCode.ToString();
            $global:httpCode = [int]$res.StatusCode;
            $cookieC = $res.Cookies;
            $resHeaders = $res.Headers;
            $global:rescontentLength = $res.ContentLength;
            $global:location = $null;

            try {
                $global:location = $res.Headers["Location"].ToString();
                return $global:location;
            }
            catch {
            }

            return $null;
        }
        catch {
            $res2 = $_.Exception.InnerException.Response;
            $global:httpCode = $_.Exception.InnerException.HResult;
            $global:httperror = $_.exception.message;

            try {
                $global:location = $res2.Headers["Location"].ToString();
                return $global:location;
            }
            catch {
            }
        }

        return $null;
    }

    function ReplaceTokensInFile($ht, $filePath) {
        $template = Get-Content -Raw -Path $filePath

        foreach ($paramName in $ht.Keys) {
            $template = $template.Replace($paramName, $ht[$paramName])
        }

        return $template;
    }


az login

$subscriptionId = (az account show --query 'id' -o tsv)
 
#for powershell...
Connect-AzAccount -DeviceCode -SubscriptionId $subscriptionId

$starttime = get-date

#download azcopy command
if ([System.Environment]::OSVersion.Platform -eq "Unix") {
    $azCopyLink = Check-HttpRedirect "https://aka.ms/downloadazcopy-v10-linux"

    if (!$azCopyLink) {
        $azCopyLink = "https://azcopyvnext.azureedge.net/release20200709/azcopy_linux_amd64_10.5.0.tar.gz"
    }

    Invoke-WebRequest $azCopyLink -OutFile "azCopy.tar.gz"
    tar -xf "azCopy.tar.gz"
    $azCopyCommand = (Get-ChildItem -Path ".\" -Recurse azcopy).Directory.FullName

    if ($azCopyCommand.count -gt 1) {
        $azCopyCommand = $azCopyCommand[0];
    }

    cd $azCopyCommand
    chmod +x azcopy
    cd ..
    $azCopyCommand += "\azcopy"
}
else {
    $azCopyLink = Check-HttpRedirect "https://aka.ms/downloadazcopy-v10-windows"

    if (!$azCopyLink) {
        $azCopyLink = "https://azcopyvnext.azureedge.net/release20200501/azcopy_windows_amd64_10.4.3.zip"
    }

    Invoke-WebRequest $azCopyLink -OutFile "azCopy.zip"
    Expand-Archive "azCopy.zip" -DestinationPath ".\" -Force
    $azCopyCommand = (Get-ChildItem -Path ".\" -Recurse azcopy.exe).Directory.FullName

    if ($azCopyCommand.count -gt 1) {
        $azCopyCommand = $azCopyCommand[0];
    }

    $azCopyCommand += "\azcopy"
}
$tenantId = (Get-AzContext).Tenant.Id
$subscriptionId = (Get-AzContext).Subscription.Id
$signedinusername = az ad signed-in-user show | ConvertFrom-Json
$signedinusername = $signedinusername.userPrincipalName


[string]$suffix = -join ((48..57) + (97..122) | Get-Random -Count 7 | % { [char]$_ })
$rgName = "rg-FabricIQ-$suffix"
$Region = read-host "Enter the region for deployment"
$subscriptionId = (Get-AzContext).Subscription.Id
$tenantId = (Get-AzContext).Tenant.Id
$Fabric_capacity_name = "capacityfabric$suffix"


Write-Host "Deploying Resources on Microsoft Azure Started ..."
Write-Host "Creating $rgName resource group in $Region ..."
New-AzResourceGroup -Name $rgName -Location $Region | Out-Null
Write-Host "Resource group $rgName creation COMPLETE"
    
Write-Host "Creating resources in $rgName..."
New-AzResourceGroupDeployment -ResourceGroupName $rgName `
    -TemplateFile "mainTemplate.json" `
    -Mode Complete `
    -location $Region `
    -capacityName $Fabric_capacity_name `
    -administratorEmails $signedinusername `
    -Force
    
$templatedeployment = Get-AzResourceGroupDeployment -Name "mainTemplate" -ResourceGroupName $rgName
$deploymentStatus = $templatedeployment.ProvisioningState
Write-Host "Deployment in $rgName : $deploymentStatus"

Write-Host "----FABRIC----"
Write-Host "Deploying resources on Microsoft Fabric Started... "
RefreshTokens

# Get Fabric capacities
 $pat_token = $fabric
 $requestHeaders = @{
 Authorization  = "Bearer" + " " + $pat_token
     "Content-Type" = "application/json"
     }

# fecth ws
$wss = Invoke-RestMethod `
 -Method GET `
 -Uri "https://api.fabric.microsoft.com/v1/capacities" `
 -Headers $requestHeaders

$wss.value | Select-Object id, displayName, sku, region
$capacityName = $Fabric_capacity_name  # Fabric capacity display name

$fabricCapacityId = (
    $wss.value |
    Where-Object { $_.displayName -eq $capacityName }
).id

$fabricCapacityId


# Create Workspace in Fabric
$WsName = "ZavaWorkspace-$suffix"

# creating Workspace
 $pat_token = $fabric
 $requestHeaders = @{
 Authorization  = "Bearer" + " " + $pat_token
     "Content-Type" = "application/json"
     }

$bodyObj = @{
    displayName = $WsName
    capacityId  = $fabricCapacityId
}

$body = $bodyObj | ConvertTo-Json -Depth 5
$body

$endPoint  = "https://api.fabric.microsoft.com/v1/workspaces"
$response = Invoke-RestMethod $endPoint `
             -Method POST `
             -Headers $requestHeaders `
             -Body $body

$workspaceId = $response.id
$workspaceId

# $url = "https://api.powerbi.com/v1.0/myorg/groups/$WsName";
# $WsName = Invoke-RestMethod -Uri $url -Method GET -Headers @{ Authorization="Bearer $powerbitoken" };
# $WsName = $WsName.Id

$lakehouseBronze =  "lakehouse$suffix"
$lakehouse_Ontology =  "lakehouse_Ontology$suffix"
# $lakehouseGold =  "lakehouseGold$suffix"

Add-Content log.txt "------FABRIC assets deployment STARTS HERE------"
Write-Host "------------FABRIC assets deployment STARTS HERE------------"

Add-Content log.txt "------Creating Lakehouses in '$WsName' workspace------"
Write-Host "------Creating Lakehouses in '$WsName' workspace------"
$lakehouseNames = @($lakehouseBronze, $lakehouse_Ontology)
# Set the token and request headers
$pat_token = $fabric
$requestHeaders = @{
Authorization  = "Bearer" + " " + $pat_token
    "Content-Type" = "application/json"
    }

# Iterate through each Lakehouse name and create it
foreach ($lakehouseName in $lakehouseNames) {
    # Create the body for the Lakehouse creation
$body = @{
        displayName = $lakehouseName
        type        = "Lakehouse"
    } | ConvertTo-Json

# Set the API endpoint
$endPoint = "https://api.fabric.microsoft.com/v1/workspaces/$workspaceId/items/"

    # Invoke the REST method to create a new Lakehouse
try {
        $Lakehouse = Invoke-RestMethod $endPoint `
            -Method POST `
            -Headers $requestHeaders `
            -Body $body

        Write-Host "Lakehouse '$lakehouseName' created successfully."
    } catch {
        Write-Host "Error creating Lakehouse '$lakehouseName': $_"
        if ($_.Exception.Response -ne $null) {
            $stream = $_.Exception.Response.GetResponseStream()
            $reader = New-Object System.IO.StreamReader($stream)
            $reader.ReadToEnd()
        }
    }
    }
Add-Content log.txt "------Creation of Lakehouses in '$WsName' workspace COMPLETED------"
Write-Host "-----Creation of Lakehouses in '$WsName' workspace COMPLETED------"

$endPoint = "https://api.fabric.microsoft.com/v1/workspaces/$workspaceId/lakehouses"
$Lakehouse = Invoke-RestMethod $endPoint `
-Method GET `
-Headers $requestHeaders

$LakehouseOntologyid = ($Lakehouse.value | Where-Object { $_.displayName -eq "$lakehouse_Ontology" }).id
RefreshTokens

# Add-Content log.txt "------Creating KQL Database------"
# Write-Host "------Creating KQL Database------"
#     $KQLDB = "Contoso-KQL-DB"
#     $body = @{
#             displayName = $KQLDB 
#             type        = "KQLDatabase"
#         } | ConvertTo-Json
        
#     try{
# $endPoint = "https://api.fabric.microsoft.com/v1/workspaces/$workspaceId/items/"
# $KQLDBAPI = Invoke-RestMethod $endPoint `
#             -Method POST `
#             -Headers $requestHeaders `
#             -Body $body
#             Write-Host "KQL-DB '$KQLDB' created successfully."
#     }catch{
#         Write-Host "Error creating KQL-DB '$KQLDB'"
#     }
# Start-Sleep -s 10 
# Add-Content log.txt "------------Creation of KQL Database COMPLETED------------"
# Write-Host "-----------Creation of KQL Database COMPLETED------------"

Add-Content log.txt "------Uploading assets to Lakehouses------"
Write-Host "------------Uploading assets to Lakehouses------------"
$tenantId = (Get-AzContext).Tenant.Id
azcopy login --tenant-id $tenantId

azcopy copy "https://stmsftbuild2024.blob.core.windows.net/copilotdata/*" "https://onelake.blob.fabric.microsoft.com/$WsName/$lakehouseBronze.Lakehouse/Tables/" --overwrite=prompt --from-to=BlobBlob --s2s-preserve-access-tier=false --check-length=true --include-directory-stub=false --s2s-preserve-blob-tags=false --recursive --trusted-microsoft-suffixes=onelake.blob.fabric.microsoft.com --log-level=INFO;
azcopy copy "https://stmsftbuild2024.blob.core.windows.net/rawdata/*" "https://onelake.blob.fabric.microsoft.com/$WsName/$lakehouseBronze.Lakehouse/Files/" --overwrite=prompt --from-to=BlobBlob --s2s-preserve-access-tier=false --check-length=true --include-directory-stub=false --s2s-preserve-blob-tags=false --recursive --trusted-microsoft-suffixes=onelake.blob.fabric.microsoft.com --log-level=INFO;
azcopy copy "https://stfabriciqlab.blob.core.windows.net/ontologylakehousetables/*" "https://onelake.blob.fabric.microsoft.com/$WsName/$lakehouse_Ontology.Lakehouse/Tables/" --overwrite=prompt --from-to=BlobBlob --s2s-preserve-access-tier=false --check-length=true --include-directory-stub=false --s2s-preserve-blob-tags=false --recursive --trusted-microsoft-suffixes=onelake.blob.fabric.microsoft.com --log-level=INFO;

Add-Content log.txt "------Uploading assets to Lakehouses COMPLETED------"
Write-Host "------------Uploading assets to Lakehouses COMPLETED------------"

$spname = "Unified Al and Analytics $suffix"

$app = az ad app create --display-name $spname | ConvertFrom-Json
$appId = $app.appId

$mainAppCredential = az ad app credential reset --id $appId | ConvertFrom-Json
$clientsecpwdapp = $mainAppCredential.password

az ad sp create --id $appId | Out-Null    
$sp = az ad sp show --id $appId --query "id" -o tsv
start-sleep -s 15

$tenantId = az account show --query tenantId -o tsv
Write-Host "Tenant ID: $tenantId"

RefreshTokens
$url = "https://api.powerbi.com/v1.0/myorg/groups";
$result = Invoke-WebRequest -Uri $url -Method GET -ContentType "application/json" -Headers @{ Authorization = "Bearer $powerbitoken" } -ea SilentlyContinue;
$homeCluster = $result.Headers["home-cluster-uri"]
#$homeCluser = "https://wabi-west-us-redirect.analysis.windows.net";

RefreshTokens
$url = "$homeCluster/metadata/tenantsettings"
$post = "{`"featureSwitches`":[{`"switchId`":306,`"switchName`":`"ServicePrincipalAccess`",`"isEnabled`":true,`"isGranular`":true,`"allowedSecurityGroups`":[],`"deniedSecurityGroups`":[]}],`"properties`":[{`"tenantSettingName`":`"ServicePrincipalAccess`",`"properties`":{`"HideServicePrincipalsNotification`":`"false`"}}]}"
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Authorization", "Bearer $powerbiToken")
$headers.Add("X-PowerBI-User-Admin", "true")
#$result = Invoke-RestMethod -Uri $url -Method PUT -body $post -ContentType "application/json" -Headers $headers -ea SilentlyContinue;

#add PowerBI App to workspace as an admin to group
RefreshTokens
$url = "https://api.powerbi.com/v1.0/myorg/groups/$workspaceId/users";
$post = "{
`"identifier`":`"$($sp)`",
`"groupUserAccessRight`":`"Admin`",
`"principalType`":`"App`"
}";

$result = Invoke-RestMethod -Uri $url -Method POST -body $post -ContentType "application/json" -Headers @{ Authorization = "Bearer $powerbitoken" } -ea SilentlyContinue;

#get the power bi app...
$powerBIApp = Get-AzADServicePrincipal -DisplayNameBeginsWith "Power BI Service"
$powerBiAppId = $powerBIApp.Id;

#setup powerBI app...
RefreshTokens
$url = "https://graph.microsoft.com/beta/OAuth2PermissionGrants";
$post = "{
`"clientId`":`"$appId`",
`"consentType`":`"AllPrincipals`",
`"resourceId`":`"$powerBiAppId`",
`"scope`":`"Dataset.ReadWrite.All Dashboard.Read.All Report.Read.All Group.Read Group.Read.All Content.Create Metadata.View_Any Dataset.Read.All Data.Alter_Any`",
`"expiryTime`":`"2021-03-29T14:35:32.4943409+03:00`",
`"startTime`":`"2020-03-29T14:35:32.4933413+03:00`"
}";

$result = Invoke-RestMethod -Uri $url -Method GET -ContentType "application/json" -Headers @{ Authorization = "Bearer $graphtoken" } -ea SilentlyContinue;

#setup powerBI app...
RefreshTokens
$url = "https://graph.microsoft.com/beta/OAuth2PermissionGrants";
$post = "{
`"clientId`":`"$appId`",
`"consentType`":`"AllPrincipals`",
`"resourceId`":`"$powerBiAppId`",
`"scope`":`"User.Read Directory.AccessAsUser.All`",
`"expiryTime`":`"2021-03-29T14:35:32.4943409+03:00`",
`"startTime`":`"2020-03-29T14:35:32.4933413+03:00`"
}";


$result = Invoke-RestMethod -Uri $url -Method GET -ContentType "application/json" -Headers @{ Authorization = "Bearer $graphtoken" } -ea SilentlyContinue;

$spObjectId = az ad sp show --id $appId --query id -o tsv
az role assignment create --assignee-object-id $spObjectId --role "Azure AI User" --scope "/subscriptions/$(az account show --query id -o tsv)/resourceGroups/$rgName"


$credential = New-Object PSCredential($appId, (ConvertTo-SecureString $clientsecpwdapp -AsPlainText -Force))

# Connect to Power BI using the service principal
Connect-PowerBIServiceAccount -ServicePrincipal -Credential $credential -TenantId $tenantId

pip install --user --upgrade pip setuptools
pip install --user packaging  # Packaging is required by ansible-core
pip install --user cryptography
pip install --user ms-fabric-cli


fab config set encryption_fallback_enabled true

fab auth login --username $appId --password $clientsecpwdapp --tenant $tenantId
$KQLDB = "Zava-KQL-DB"
$OntologyworkspacePath = "$WSName.Workspace"
fab mkdir $OntologyworkspacePath/$KQLDB.eventhouse
Start-Sleep -s 10 
RefreshTokens

$requestHeaders = @{
    Authorization  = "Bearer" + " " + $fabric
    "Content-Type" = "application/json"
}
$endPoint = "https://api.fabric.microsoft.com/v1/workspaces/$workspaceId/eventhouses"

# Get Eventhouse details
# Make GET request to list all Eventhouses
try {
    $response = Invoke-RestMethod -Method Get -Uri $endpoint -Headers $requestHeaders

    # Filter by display name
    $eventhouse = $response.value | Where-Object { $_.displayName -eq $KQLDB }

    if ($eventhouse) {
        $eventhouseId = $eventhouse.id
        $queryUri = $eventhouse.properties.queryServiceUri
        $ingestUri = $eventhouse.properties.ingestionServiceUri

        Write-Host "✅ Eventhouse found:"
        Write-Host "Display Name: $eventhouseName"
        Write-Host "Eventhouse ID: $eventhouseId"
        Write-Host "Query URI: $queryUri"
        Write-Host "Ingestion URI: $ingestUri"
    }
    else {
        Write-Host "❌ Eventhouse '$eventhouseName' not found in workspace $workspaceId"
    }
}
catch {
    Write-Host "❌ Error retrieving Eventhouse list from workspace $workspaceId"
}


## notebooks
Add-Content log.txt "-----Configuring Fabric Notebooks w.r.t. current workspace and lakehouses-----"
Write-Host "----Configuring Fabric Notebooks w.r.t. current workspace and lakehouses----"




Add-Content log.txt "-----Uploading Notebooks-----"
Write-Host "-----Uploading Notebooks-----"
RefreshTokens
$requestHeaders = @{
Authorization  = "Bearer " + $fabric
"Content-Type" = "application/json"
"Scope"        = "Notebook.ReadWrite.All"
}




(Get-Content -path "artifacts/fabricnotebooks/Generate Realtime data.ipynb" -Raw) | Foreach-Object { $_ `
-replace '#LakehouseOntology#', $LakehouseOntologyid `
-replace '#WorkspaceId#', $workspaceId `
-replace '#EventhouseId#', $queryUri `
-replace '#KQLDB#', $KQLDB
} | Set-Content -Path "artifacts/fabricnotebooks/Generate Realtime data.ipynb"

$files = Get-ChildItem -Path "./artifacts/fabricnotebooks" -File -Recurse
Set-Location ./artifacts/fabricnotebooks

foreach ($name in $files.name) {
if ($name -eq "Generate Realtime data.ipynb") {
$fileContent = Get-Content -Raw $name
$fileContentBytes = [System.Text.Encoding]::UTF8.GetBytes($fileContent)
$fileContentEncoded = [System.Convert]::ToBase64String($fileContentBytes)

$body = '{
"displayName": "' + $name + '",
"type": "Notebook",
"definition": {
"format": "ipynb",
"parts": [
{
    "path": "artifact.content.ipynb",
    "payload": "' + $fileContentEncoded + '",
    "payloadType": "InlineBase64"
}
]
}
}'

$endPoint = "https://api.fabric.microsoft.com/v1/workspaces/$workspaceId/items/"

$Lakehouse = Invoke-RestMethod $endPoint -Method POST -Headers $requestHeaders -Body $body

Write-Host "Notebook uploaded: $name"
}
}
Add-Content log.txt "-----Uploading Notebooks COMPLETED-----"
Write-Host "-----Uploading Notebooks COMPLETED-----"

cd..
cd..

fab auth login --username $appId --password $clientsecpwdapp --tenant $tenantId

$notebookPath1 = "$OntologyworkspacePath/Generate Realtime data.ipynb.Notebook"

# Build the JSON input string
$jsonInput1 = @{
known_lakehouses = @(@{ id = $LakehouseOntologyid })
default_lakehouse = $LakehouseOntologyid
default_lakehouse_name = $lakehouseOntology
default_lakehouse_workspace_id = $workspaceId
} | ConvertTo-Json -Compress


fab set "$notebookPath1" -q lakehouse -i $jsonInput1 -f

Start-Sleep -s 100

fab auth login --username $appId --password $clientsecpwdapp --tenant $tenantId

fab job run "$OntologyworkspacePath/Generate Realtime data.ipynb.Notebook"

