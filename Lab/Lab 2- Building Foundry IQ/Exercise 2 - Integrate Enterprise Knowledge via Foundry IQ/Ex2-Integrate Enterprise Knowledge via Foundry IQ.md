 ## Integrate Enterprise Knowledge via Foundry IQ

This lab would be a hands-on Lab to give you a better idea on how to Integrate Enterprise Knowledge using Foundry ID.

### Task 2.1: Configure Foundry IQ by setting up indexed sources for unstructured files and federated sources for real-time structured data retrieval. 

1. Click on Build in the Foundry portal. On the left side, click on **Knowledge** to configure Foundry IQ.

    ![Select step 1](../../media/image14.png)

2. Click on drop down of **Foundry IQ Connection** and then click on **Connect a resource**.

    ![Select step 2](../../media/image15.png)

3. Click on drop down of **Azure AI Search** field and select the Search resource created under the name **srch-foundry-iq-lab** and click on **Connect**. 

    ![Select step 3](../../media/image16.png)

4. Click on **Create a knowledge base**.

    ![Step 4.png](../../media/image17.png)

5. Click on **Azure Blob Storage** to index unstructured return policy files  and click on **Connect**.

    ![Step 5.png](../../media/image18.png)

6. Paste **return-policies** in the Name field. From the drop-down, select the **storage account**, then select the container **returnpolicy**. Scroll down and select the **checkbox** to include embedding model. Under the Embedding model, click **Select model**, then click **Browse more models**.

    ![Step 6.png](../../media/image19.png)

7. Click on **text-embedding-ada-002** and click on **Deploy**.

    ![Step 7 Image](../../media/image21.png)

8. Select **text-embedding-ada-002** for Embedding model field and then click on **Create**.
    ![Step 8 Image](../../media/image22.png)

9. In the same **Knowledge base** page, at **Knowledge source** section, click on **Create new** and then click on **Azure AI Search Index**.

    ![Step 9.png](../../media/image23.png)

10. Paste **product-catalog** in the Name field. From the drop-down, select the **product-catalog-index**, then click on **Create**.

    ![Step 10.png](../../media/image24.png)


### Task 2.2: Link the AI Foundry project to a Microsoft Fabric Lakehouse to enable direct access to enterprise data without the need for data movement.

1. In the same **Knowledge base** page, at **Knowledge source** section, click on **Create new** and then click on **Microsoft OneLake** to connect Lakehouse to enable direct access to enterprise data without the need for data movement.

    ![Step 1.png](../../media/image25.png)

2. Navigate to **Microsoft Fabric**, click on **Workspace** and click on **TechExperience-Lab001**

    ![Step 2.png](../../media/image26.png)

3. Click on **Filter dropdown**, then select **Lakehouse** and click on **FoundryIQ**

    ![Step 3.png](../../media/image27.png)

4. Copy the **Fabric Workspace ID** and the **Lakehouse ID** that appear before lakehouse and after lakehouse.

    > You can find the Fabric Workspace ID  easily in the URL, it's the unique string inside two / characters after /groups/ in your browser window.
    
    >You can find the Lakehouse ID easily in the URL, it is the unique string inside two / characters after /lakehouses/ in your browser window.

    ![Step 4.png](../../media/image29.png)

5. Navigate back to Microsoft Foundry, paste the previously copied **Fabric Workspace ID** and the **Lakehouse ID**, select **text-embedding-ada-002** and then click on **Create**

    ![Step 5.png](../../media/image28.png)

6. Review all the **Knowledge sources**, in Basic configuration section. For the **Chat completion model** field select the **gpt-4o**.  Click on **Save** knowledge base.

    ![Step 6.png](../../media/image31.png)