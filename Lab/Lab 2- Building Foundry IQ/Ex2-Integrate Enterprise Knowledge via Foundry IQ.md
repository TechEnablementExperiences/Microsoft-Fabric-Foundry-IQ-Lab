# Exercise 2: Integrate Enterprise Knowledge via Foundry IQ
 
This exercise focuses on integrating enterprise knowledge using **Foundry IQ** by enabling indexed sources for unstructured data and federated sources for real-time structured data retrieval, along with connectivity to the **Microsoft Fabric Lakehouse**.

**Ryan** (Customer) asks detailed product-related questions during an engagement.

To enable accurate and context-aware responses, Miguel integrates enterprise content sources such as:
- SharePoint Product Guides  
- Internal Policy Documents  
- Campaign and Marketing Materials  

**Foundry IQ** provides permission-aware, citation-backed grounding by connecting to these knowledge sources — ensuring that agent responses are both secure and traceable.

> *“The agent shouldn’t know everything — it should know who to ask.”*

## ✅ Outcome
- Foundry IQ Knowledge Base configured  
- Multi-source enterprise grounding enabled  
- No custom RAG code required for knowledge integration

### Task 2.1: Set up indexed sources for unstructured files and federated sources for real-time structured data retrieval. 

1. Click on Build in the Foundry portal. On the left side, click on **Knowledge** to configure Foundry IQ.

    ![Select step 1](../media/image14.png)

2. Click on drop down of **Foundry IQ Connection**, then click on **Connect a resource**.

    ![Select step 2](../media/image15.png)

3. Click on the dropdown for the **Azure AI Search** field, select the Search resource named **srch-foundry-iq-lab**, and then click on **Connect**. 

    ![Select step 3](../media/image16.png)

4. Click on **Create a knowledge base**.

    ![Step 4.png](../media/image17.png)

5. Click on **Azure Blob Storage** to index unstructured return policy files, then click on **Connect**.

    ![Step 5.png](../media/image18.png)

6. Paste **return-policies** in the Name field. From the dropdown, select the **storage account**, then select the container **returnpolicy**. Scroll down and select the **checkbox** to include embedding model. Under the Embedding model, click **Select model**, then click **Browse more models**.

    ![Step 6.png](../media/image19.png)

7. Click on **text-embedding-ada-002**, then click on **Deploy**.

    ![Step 7 Image](../media/image21.png)

8. Select **text-embedding-ada-002** for the Embedding model field, then click on **Create**.
    ![Step 8 Image](../media/image22.png)

9. In the same **Knowledge base** page, in the **Knowledge source** section, click on **Create new** and then click on **Azure AI Search Index**.

    ![Step 9.png](../media/image23.png)

10. Paste **product-catalog** in the Name field. From the dropdown, select **product-catalog-index**, then click on **Create**.

    ![Step 10.png](../media/image24.png)


### Task 2.2: Connect to a Microsoft Fabric Lakehouse to enable direct access to enterprise data

1. On the same **Knowledge base** page, in the **Knowledge source** section, click on **Create new** and then click on **Microsoft OneLake** to connect Lakehouse to enable direct access to enterprise data without the need for data movement.

    ![Step 1.png](../media/image25.png)

2. Navigate to **Microsoft Fabric**, click on **Workspace** and then click on **<inject key= "WorkspaceName" enableCopy="false"/>**

    ![Step 2.png](../media/image26.png)

3. Click on **Filter dropdown**, then select **Lakehouse** and then click on **<inject key= "Lakehouse" enableCopy="false"/>**

    ![Step 3.png](../media/image27.png)

4. Copy the **Fabric Workspace ID** and the **Lakehouse ID** that appear before lakehouse and after lakehouse.

    > You can find the Fabric Workspace ID in the URL. It is the unique string between two "/" characters after /groups/ in your browser.
    
    >You can find the Lakehouse ID in the URL. It is the unique string between two "/" characters after /lakehouses/ in your browser.

    ![Step 4.png](../media/image29.png)

5. Navigate back to Microsoft Foundry, paste the previously copied **Fabric Workspace ID** and the **Lakehouse ID**, select **text-embedding-ada-002**, and then click on **Create**

    ![Step 5.png](../media/image28.png)

6. Review all the **Knowledge sources** in the Basic configuration section. For the **Chat completion model** field, select **gpt-4o**.  Click on **Save** knowledge base.

    ![Step 6.png](../media/image31.png)

### What We Learned

- How to configure Foundry IQ by connecting to Azure AI Search and creating knowledge bases.
- How to index unstructured data from Azure Blob Storage and structured data from Azure AI Search indexes.
- How to connect to Microsoft Fabric Lakehouse for direct access to enterprise data.

### Next Exercise

In the next exercise, we will learn how to build intelligent agents with tool calling, including creating agent personas and implementing routing logic for user queries.
