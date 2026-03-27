 ## Provision the AI Foundry Foundation

## Summary

This Exercise is about provisioning the AI Foundry Foundation, including creating a Foundry Hub and Project, and deploying base models such as GPT-4o and text-embedding-ada-002.

### Task 1.1: Provision a Foundry Hub and Project 


1. Copy the following URL and open it in a new browser tab to access Microsoft Foundry: **<inject key= "aiFoundryPortalUrl" enableCopy="true"/>**

2. Click on **Build** to create agents, deploy models, and build workflows.

   > **Note:** Make sure the **New Foundry** toggle is turned On.
   > This setting is required to use the latest Foundry portal UI.

   ![Step 7 Image](../media/image7.png)

### Task 1.2: Deploy LLM and embedding models

 In this task, you will deploy a reasoning model and an embedding model in Foundry.

1. On the Microsoft Foundry page, click on **Models**, then click on **Deploy base models**.

    ![Select Models](../media/image8.png)

2. Search for **gpt-4o** then click on **gpt-4o**.

    ![Deploy gpt-4o](../media/image9.png)

3. Click on the **Deploy** dropdown and select **Default settings**.

    ![Deploy model](../media/image11.png)

4. Again navigate to the **Models** section to deploy embedding model, then click on **Deploy base models**.

    ![Select Models](../media/image8.png)

5. Search for **text-embedding-ada**, then click on **text-embedding-ada-002**.

    ![Step 5.png](../media/image12.png)

6. Click on the **Deploy** dropdown and select **Default settings**.

    ![Step 6.png](../media/image13.png)

### What We Learned

- How to access the Azure Portal and navigate to the Foundry portal.
- How to deploy LLM and embedding models in Foundry using default settings.

### Next Exercise

In the next exercise, we will learn how to integrate enterprise knowledge using Foundry IQ, including setting up indexed sources for unstructured files and connecting to Microsoft Fabric Lakehouse for real-time structured data retrieval.
