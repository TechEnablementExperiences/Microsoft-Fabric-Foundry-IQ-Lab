# Exercise 4: 🤖 Creating a Data Agent with Ontology

In this section, you will create a Fabric Data Agent and connect it to the ontology to enable natural language queries for retrieving business insights from enterprise data.

**Serena (Data Analyst)** now asks:
> *“Which stores had the highest stock outs and highest demand last quarter?”*
Instead of writing complex SQL queries, Serena interacts directly with a **Fabric Data Agent** that is grounded in the Ontology — enabling intuitive, context-aware analytics using natural language.

## ✅ Outcome
- Fabric Data Agent successfully connected to the Ontology  
- Cross-domain insights generated using natural language queries  
- Trusted and explainable responses powered by governed business context

## Task 4.1: Create a data agent with an ontology as the data source
1. Navigate to your **Fabric Workspace**.

2. In your Fabric workspace, click on the **New item** button in the top command bar.

3. In the **New item** creation pane, use the search bar to type **"Data Agent"**.

4. Select the **Data Agent** card in the search results and click on it to initiate creation.

     ![DAnavigation](../media/DAnavigation.png)

5. Paste **Ontology_DataAgent** in the **Create data agent** field and click on **Create** button.

     ![Agentcreation](../media/Agentcreation.png)

#### Step 1: Attach Ontology as Data Source

1. Once the Data Agent opens, navigate to the **Data** tab in the Explorer pane, click on **Add Data**, select **Data source**, then browse and select the **Ontology** created in the previous lab.

    ![datasource](../media/datasource.png)

2. Choose the Ontology created in the previous lab, then click on **Add** and verify that the ontology is successfully attached.

    ![Dataaddition](../media/Dataaddition.png)

> **Note:**  
> - The Ontology acts as a semantic layer, helping the Data Agent understand the data context.  
> - Ensure the correct ontology is selected to get accurate insights.

## Task 4.2: Validate the data agent using natural language queries

1. Verify that the **Ontology (e.g., Retail_Ontology)** is successfully added under the **Data** tab in the Explorer pane.
  
     ![Agentinstr](../media/Agentinstr.png)     
    
2. Click on **Agent instructions** from the top menu.

     ![AgentInstruction](../media/AgentInstruction.png) 

3. In the **Agent instructions** section, remove any existing default content present in the instruction box, provide guidance to control how the agent responds by entering instructions. 

     
    ### Sample Agent Instructions (Copy & Paste)

    Copy the below instructions and paste them into the **Agent instructions** section:

     ```
     **Purpose:**
     This data agent is designed to answer analytical and operational questions for retail business users using the Retail_Ontology, which integrates Lakehouse (historical) and Eventhouse (real-time) data.

     **Planning Rules**
     - Understand the user intent: classify into Sales, Inventory, Customer, Promotion, Supply Chain, or Forecasting
     - Identify whether the question requires:
     - Historical analysis → use Lakehouse entities
     - Real-time / near real-time insights → use Eventhouse entities (DemandSignal, Inventory updates, etc.)
     - Break complex queries into:
     - Entity identification
     - Relationship traversal
     - Metric aggregation
     - Always validate:
     - Time filters (date, period)
     - Granularity (store, region, product, category)

   **Data Source Mapping**
   - Sales & Orders
     - Order, OrderLine → revenue, quantity,    transactions
   - Customer Insights
     - Customer → segmentation, behavior
   - Product Analysis
     - Product, ProductCategory → product performance
   - Inventory & Supply Chain
     - Inventory, Shipment, Warehouse, Store → stock    levels, fulfillment
   - Promotions
     - Promotion → campaign effectiveness
   - Returns
     - Return → return rates, defects
   - Forecast & Demand
     - Forecast → planned demand
     - DemandSignal (Eventhouse) → real-time demand    spikes
   - Geography
     - Region → regional performance
   
   **Terminology Standardization**
   - Revenue = Sum(OrderLine.LineTotalAmount)
   - Sales Volume = Sum(OrderLine.quantity)
   - Inventory Level = Available stock in Inventory
   - Demand = Forecast or DemandSignal depending on    context
   - Conversion Rate = Orders / Customers
   - Return Rate = Returns / Orders
   
   **Query Behavior Rules**
   - Prefer aggregated insights over raw data unless    explicitly requested
   - Always:
     - Apply relevant filters (date, region, product)
     - Use joins via ontology relationships (e.g.,    Order → Customer → Region)
   - For ambiguous queries:
     - Ask clarifying questions OR
     - Provide best assumption with explanation
   
   **Response Style**
   - Clear, business-friendly explanations
   - Include:
     - Key insights
     - Supporting metrics
     - Trends (if time-based)
   - Use bullet points for readability
   - Highlight anomalies or patterns
   - Avoid overly technical database language

     ```

4. After entering the instructions, click on **Publish** to save the configuration.

    ![agentpublish](../media/agentpublish.png)

5. After adding the instructions, click on the **close (✕) icon** on the **Agent instructions** tab to exit the window.

     ![agentclosing](../media/agentclosing.png)

6. Once closed, the main Data Agent interface will be displayed, where you can start querying the agent using natural language.

7. In the query input area, ask questions using natural language, for example:
    ````
       Which customer generated the highest total sales amount?
    ````
8. Submit the query and review the response generated by the Data Agent.

     ![agentresponse](../media/agentresponse.png)

9. Observe how the agent:
   - Interprets the question  
   - Queries the underlying data using the ontology  
   - Provides insights in a readable format  

10. Try multiple queries and refine your questions to explore additional insights.
     ```
     - Which products are frequently returned and impacting revenue?
     - Which regions are underperforming in sales?
     - Which products are at risk of stockout?
     - Which stores have the highest number of orders?
     ```

> **Note:**  
> - Clear and specific questions provide more accurate results.  
> - Responses may vary depending on how the question is framed.  
> - The Data Agent uses the Ontology to translate natural language into meaningful queries.