# Build Real-Time Intelligence and Operations Agent

## Section 1: Real-Time Intelligence (RTI)

### Task 1.1: Create Real-Time Data Streams
In this task, you will configure a real-time data stream using Eventstream and connect it to the Eventhouse created in the previous lab. You will also generate streaming data and ingest it into a KQL database table.

#### Step 1: Creating Eventstream

1. In your Fabric workspace, click on the **New item** button in the top command bar.
2. In the New item creation pane, use the search bar to type **"Eventstream"**.
3. Select the **Eventstream** card in the search results and click on it to initiate creation.

   ![ESnavigation](../../media/ESnavigation.png)

4. The **New Eventstream** dialog box will appear, Enter the name as **`Inventory_ES`** then click on **create**

   ![EScreation](../../media/EScreation.png)

5. Once the Eventstream is created, it will open automatically.On the Eventstream canvas, you will see options to start building the data flow.
6. Click on **Use custom endpoint** to begin configuring the real-time data stream.

    ![ESsource](../../media/ESsource.png)  

7. In the **Custom endpoint** configuration window, enter the source name as **Inventory-Source** and click on **Add**.

    ![ESendpoint](../../media/ESendpoint.png)  

#### Step 2: Configure Destination (Eventhouse)

1. After adding the custom endpoint source, the Eventstream canvas will open.

2. Ensure you are in **Edit mode** (as shown at the top right).  
   > Changes will be applied only after publishing.

3. Click on **Transform events or add destination** on the right side of the canvas.

4. From the options displayed, select **Eventhouse** under Destinations.
 
      ![ESdestinaion](../../media/ESdestinaion.png)  

5. The **Eventhouse settings** panel will open on the right side.

6. Configure the following details:
   - Select the **Eventhouse** created in the previous lab
   - Choose the **default KQL database**
   - In the table section, select **Create new table**

7. Enter the table name as: **`inventory`**

8. Click on **Done** to save the destination configuration.

9. Click on **Save** to save the Eventstream changes.

     ![DSsetting](../../media/DSsetting.png) 

10. Click on **Publish**

    ![publish](../../media/publish.png) 

> **Note:**  
> - Ensure you are in **Edit mode** before making changes.  
> - The destination configuration will route incoming streaming data to the Eventhouse table.  
> - The table `inventory` will be created automatically during data ingestion. 

#### Step 3: Retrieve Connection Details (SAS Authentication)

1. In the Eventstream canvas, ensure the status is set to **Live** (top right corner).

2. Click on the **Inventory (Custom endpoint)** source box.

3. In the bottom **Details** section, click on **SAS Key Authentication**.

4. Locate the **Event hub name** and click on the **Copy (📋) icon** next to it.

5. Locate the **Primary key**:
   - Click on the **Eye (👁️) icon** to reveal the key
   - Then click on the **Copy (📋) icon** to copy the value

6. Save both values (Event hub name and Primary key) in notepad, as they will be used in the notebook to send real-time data.

   ![endpointdetails](../../media/endpointdetails.png)

> **Note:**  
> - These credentials allow external applications (like notebooks) to push data into Eventstream.  
> - Ensure values are copied correctly without extra spaces.

#### Step 4: Generate Real-Time Data using Notebook

1. Navigate to your **Fabric Workspace**.

2. On the workspace homepage, click on the **Import** option.

3. From the available options, select **Notebook**. 

4. Choose **From this computer** as the source.

    ![Notebookimport](../../media/Notebookimport.png) 

5. Browse and select the provided notebook file from your **VM system**.

6. Click on **Upload** to import the notebook.

     ![uploadss](../../media/uploadss.png) 

7. Once the notebook is imported, open it from the workspace.
8. In the notebook, go to the **Explorer** pane on the left side.

9. Click on **+ Add data items**.

10. From the options displayed, select **From OneLake catalog**.
 
      ![LHAttachment](../../media/LHAttachment.png)

11. Browse and select the **Lakehouse** created in the previous steps.

12. Click **Add** to attach the Lakehouse to the notebook.

      ![LHaddition](../../media/LHaddition.png)

13. Verify that the Lakehouse is successfully attached:

14. Locate the section in the notebook where the following parameters are defined:
    - **Event Hub name**
    - **Primary key**

15. Replace these values with the details copied earlier from the Eventstream:
    - Paste the **Event Hub name**
    - Paste the **Primary key**

    ![NBconfiguration](../../media/NBconfiguration.png)

16. Next, locate the query or code section where the Lakehouse name is referenced (for example: `Fabric_IQ`).

17. Replace the existing Lakehouse name with your **own Lakehouse name** (the one created in previous steps).

    ![NBchanges](../../media/NBchanges.png)

18. Ensure all required values are updated correctly:
    - Event Hub name ✅  
    - Primary key ✅  
    - Lakehouse name ✅  

19. After updating the values, click on **Run this cell and all below** to execute the notebook.

    ![runall](../../media/runall.png)

20. The notebook will:
    - Generate real-time streaming data
    - Send data to Eventstream using the custom endpoint
    - Automatically load data into the Eventhouse table (`inventory`)

> **Note:**  
> - Make sure there are no extra spaces while copying values.  
> - Incorrect Event Hub details will result in no data ingestion.  
> - Ensure the Lakehouse name is updated correctly to avoid query errors.

#### Step 5: Validate Data in Eventhouse

1. Navigate to the **Eventhouse** created in the previous lab.

     ![EHnavigation](../../media/EHnavigation.png)

2. Once the Eventhouse opens, go to the **Retail_Eventhouse**. click on **Retail_Eventhouse**, it will load datase in seperate tab.

    ![Eventhouse Dashboard](../../media/EventhouseDashboard.png)

3. In the database explorer, expand the **Tables** section and locate the **`inventory`** table from the available list.

     ![TablecheckingEH](../../media/TablecheckingEH.png)

4. In the left pane, under **KQL databases**, select your database (e.g., `Retail_EventHouse_queryset`). In the query editor, enter the following query to view sample data:

       ```
       kql
            inventory
            | take 10 
       ```

![EHquery](../../media/EHquery.png)

5.Click on the Run button at the top to execute the query.
6.Observe the results displayed at the bottom:
  - A table with columns such as StoreId, ProductID, Quantity, etc.
  - This confirms that real-time data is successfully ingested into the inventory table

  > **Note:**  
  > - If no data appears, wait a few seconds and click Run again.
  > - Ensure the Eventstream is in Live mode and the notebook executed successfully.

## Section 2: Operation Agent

### Task 2.1: Creating Operation Agent
1. Select Fabric Workspace and click **New Item**.
2. In the search box type **Opertion** keywork to get Operation Agent. Click **Operation Agent**.

    ![Choose OperationAgent](../../media/ChooseOperationAgent.png)

3. New popup window will apear. Provide Opeation Agent name and select workspace in the Location section. Click **Create**.

    ![Choose OperationAgent](../../media/NewOperationAgent.png)

4. After create, Opearation Agent will load its blank play area. 

    ![OA PlayArea](../../media/OperationAgentPayArea.png)

5. Opeartion Agent has sections like **Business goal**, **Agent instructions**, **Knowledge**, **Action**. Right side we have **Agent playbook** area.

6. Provide **Business goal** for RTI.

    ![BusinessGoal](../../media/BusinessGoal.png)

7. Proide **Agent instuction** which agent will follow all the instructions and take action.

    ![AgentInstructions](../../media/AgentInstructions.png)

8. If instuction length is bigger then hold & drag bottom right corner to expand the wondow. So that, all instruction can be visible.

9. Add knowledge base in the **Knowledge** section. Click **Add data**.

    ![AddKnowledge](../../media/AddKnowledge.png)

10. Chose **Eventhosue** to add in the knoweldge section

    ![KQLDatabase](../../media/OA-KB-KQLDatabase.png)

11. Click **Save** button to generate **Agent playbook**

    ![GeneratingPlaybook](../../media/GeneratingPlaybook.png)

12. After few moment, Agent playbook will be generate with all its step by step action details.

    **Playbook - Business glossary & Objects**
        ![Paybook-I](../../media/Paybook-I.png)

    **Playbook - Properties and Rules**
    ![Paybook-II](../../media/Paybook-II.png)

13. Read the **Agent playbook** and start the **Opertion Agent** if all instructions are correct.

14. Now, Operation Agent is ready to track, monitor, and sending alert message if any anomaly detected.

### Task 2.2: Adding custome action
Custom action will help to get message from **Operation Agent** and take nessary action based on the instruction.

1. Creating **Custom Action** with clicking **Add action**

    ![ActionCreation](../../media/ActionCreation.png)

2. Now action creation popup will appear to include action name and its description. Also, user can pass parameter for explicit specifiction while taking action. Click **Create** to create custom action.

    ![CreatingAction](../../media/CreatingAction.png)

3. Now, custom action will be created for operation agent.

    ![ActionCreated](../../media/ActionCreated.png)

4. Action need to configure **Custom Action**. User need to click **Connect** for configuration.

5. In custom action configuration pan, user need to choose **Workspace**, **Activator** (if not available, select and click **New activator**). 

    ![ActionConfiguration](../../media/ActionConfiguration.png)

   - Click **Create a connection** button to get connection details for activator.
   - After connection creation, please copy the connection string and save at safe place.
   - Click **Open flow builder** a PowerAutomate flow to open in a separate browser tab.

6. In PowerAutomate flow page, click **Activator** action to open its properties page.
    - Paste the connection string which was copied.
    - Sign in to the account for proper authorise if not connected.

    ![PowerAutomateActivatorSetting](../../media/PowerAutomateActivatorSetting.png)

7. Only activator will not work here. So use sould add output action.

8. Click "'+'" (available below activator action) to insert new action.

    ![NewItemPowerAutomate](../../media/NewItemPowerAutomate.png)

9. In action selection pan, please search **Team** to establich Tean Chat. Click **See all** to visualize all actions for Team.

    ![FindTeamAction](../../media/FindTeamAction.png)

10. Select **Get msssages in chat** from te list. This will help **Activator** action to post message in team.

    ![GetMessageChat](../../media/GetMessageChat.png)

11. User need to authorize Team with providing account for message communication.

    - Click **Sign in** to autorize account

    ![SignInAccountForTeam](../../media/SignInAccountForTeam.png)
    