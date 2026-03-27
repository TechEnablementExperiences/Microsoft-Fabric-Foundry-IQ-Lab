# Prerequisites for Building Intelligent Solutions with Microsoft Fabric IQ & Foundry IQ – Hands-on Lab

### ✅ Access Requirements
- Contributor-level permission on the Azure Resource Group or Subscription.

### ✅ Licenses/Capacity
- Microsoft Fabric Capacity (**F8 or F16 SKU**) for individual lab profiles.
- Microsoft 365 Access:
  - Outlook
  - Microsoft Teams
  - Power Automate (Trial License)
 

### ✅ Required Azure Resources  
The following Azure services will be deployed using an **ARM Template**:

- Azure Data Lake Storage Gen2 (ADLS)
- Azure Cosmos DB
- Azure AI Search
- Microsoft Foundry
- Azure OpenAI Service  
  - Model: `gpt-4o`  
  - Embedding Model: `text-embedding-ada-002`

---
### Need to enable Ontology in Fabric tenant

1. **Ontology item (preview)**, **Graph (preview)**, **XMLA endpoints**, and **Data agent item types (preview)** enabled on the tenant.

2. Navigate to [Fabric](app.powerbi.com). Click on **Settings** and select **Admin portal**.

   ![](https://github.com/TechEnablementExperiences/Microsoft-Fabric-and-Foundry-IQ/blob/main/Lab/media/pre-3.png)

3. In the **tenant settings**, enable **Ontology item (preview)**.

    ![](https://github.com/TechEnablementExperiences/Microsoft-Fabric-and-Foundry-IQ/blob/main/Lab/media/pre-2.png)

4. Enable **Graph (preview)**.

    ![](https://github.com/TechEnablementExperiences/Microsoft-Fabric-and-Foundry-IQ/blob/main/Lab/media/pre-3.png)

5. Enable **XMLA endpoints**.

   ![](https://github.com/TechEnablementExperiences/Microsoft-Fabric-and-Foundry-IQ/blob/main/Lab/media/pre-4.png)

6. Enable **Data agent item types (preview)**.

    ![](https://github.com/TechEnablementExperiences/Microsoft-Fabric-and-Foundry-IQ/blob/main/Lab/media/pre-5.png)

---

##  Lab Virtual Proctor – Prerequisites Guide

This outlines the required Azure services, configurations, and setup needed before deploying and using the **Lab Virtual Proctor (RAG-based assistant)**.

---
### 1. Azure Subscription
- Active Azure subscription  
- Contributor (or higher) access  
---
### 2. Azure Function App
- Python 3.10 / 3.11  
- Consumption or Premium plan  
- HTTP trigger enabled  

---
### 3. Azure Storage Account
- Blob storage enabled  
- Container for image uploads (e.g., `lab-images`)  

---
### 4. Azure AI Search
- Vector search enabled  

---
### 5. Azure OpenAI (Microsoft Foundry)
- Chat model: `gpt-4o-mini`  
- Embedding model: `text-embedding-ada-002` 

---
### 6. (Optional) Microsoft Foundry Project
- Centralized model and key management  

---

### ✅ Ready Check
- Function App created  
- Storage configured  
- Search index ready  
- Models deployed  
