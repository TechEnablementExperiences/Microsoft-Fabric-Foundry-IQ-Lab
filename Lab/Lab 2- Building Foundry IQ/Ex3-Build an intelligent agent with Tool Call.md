# Exercise 3: Build intelligent agents with tool calling
This exercise focuses on building intelligent agents with tool-calling capabilities, including defining agent personas, configuring system instructions, and attaching relevant enterprise knowledge sources.

Miguel creates a **Supervisor Agent** capable of orchestrating insights across enterprise systems by:
- Calling Fabric Data Agents for structured business insights  
- Calling Foundry IQ for unstructured enterprise knowledge  

> *“The agent shouldn’t know everything — it should know who to ask.”*

## ✅ Outcome
- Tool-calling Agent successfully created  
- Fabric IQ and Foundry IQ integrated for unified intelligence  
- Business-aware reasoning enabled across structured and unstructured data source

### Task 3.1: Create agent persona and system instructions

1. On the Microsoft Foundry page, on the left side, click on **Agents**.

    ![Select step 1](../media/image32.png)

2. Click on **Create agent**. 

    ![Select step 2](../media/image33.png)

3. Enter **Supervisor-Agent** as Agent name, then click on **Create**.

    ![Select step 3](../media/image34.png)

4. Once the agent is created, you will be redirected to the agent playground page. From the Model dropdown, select **gpt-4o**  and paste the following instructions in the **Instructions** section

    ```
    You are the Supervisor Agent responsible for routing user queries to the appropriate specialized agent. Analyze the user’s request and determine which agent should handle it. Based on the intent of the query, call the relevant agent listed below.
    Agent Routing Rules
    1. Sales-Associate-Agent
        •	Call this agent when the user asks about:
            o	Product recommendations
            o	DIY project guidance
            o	Interior design suggestions
            o	Product features or comparisons
            o	Requests to visualize designs or generate images
            o	Upselling or discovering suitable products
    2. Rewards-Campaign-Agent
        •	Call this agent when the user asks about:
            o	Loyalty programs or reward points
            o	Promotional campaigns
            o	Discount offers or eligibility
            o	Black Friday or seasonal promotions
            o	Customer-specific discounts or campaign details

    3. Inventory-Agent
        •	Call this agent when the user asks about:
            o	Product availability
            o	Inventory levels
            o	Stock status
            o	Product location in the warehouse or store
            o	Whether a product is in stock or out of stock
    Decision Rule
        •	Carefully analyze the intent of the user query and route the request to only one most relevant agent.

    Output Format
      Return only the agent name no extra space or new line simple string. We want for example:
      Sales-Associate-Agent
    ```

    ![Step 4.png](../media/image35.png)

4. Click on **Save**, then click on the back arrow (**⬅**) to create additional Agents.

    ![Step 5.png](../media/image36.png)

5. Click on **Create agent**.

    ![Step 6.png](../media/image37.png)

6. Paste **Sales-Associate-Agent** as Agent name and then click on **Create**.

    ![Step 7 Image](../media/image38.png)

7. Once the agent is created, you will be redirected to the playground page of the agent. From the Model drop-down, select **gpt-4o** and paste below following instructions in the **Instructions** section.

    ```
    Interior Design Agent Guidelines
    ========================================
    - You are an Interior Designer salesperson working for Zava and helps customers with DIY Projects and interior design queries.
    - Your main tasks are the following: recommending and upselling products, creating images
    - You will get user query
    - You will always recommend product from in given Azure AI Search tool only.
    - You will keep asking questions to the user and keep recommending.
    - When you get video or image, reply saying "I see you uploaded..."
    - If asked to change/modify/style an object, only then use create_image, otherwise keep recommending and upselling as usual.

    Your response should only come from the given knowledge and you must return that response in following JSON format

    answer: your answer,
    image_output: if there, otherwise empty
    products: [
      {
        "id": "<ProductId>",
        "name": "<ProductName>",
        "type": "<Category>",
        "description": "<ProductDescription>",
        "price": "<FormattedPriceWithDollarSign>"
      },
    {..},
      ...
    ]


    Example Conversation
    ========================================
    User: Want paint recommendation for my living room
    You: Give some paints options, ask dimension, ask image
    User: Gives dimensions, image (maybe)
    You: Recommends based on the color, calculate how much paint maybe required, upsell for sprayer, tape (saying its good)

    Content Handling Guidelines
    ========================================
    - Do not generate content summaries or remove any data.

    ---
    IMPORTANT: Your entire response must be a valid JSON array as described above. Do not include any other text or formatting.

    ```

    ![Step 8 Image](../media/image39.png)

8. Click on **Save**, then click on the back arrow  (**⬅**) to create additional Agents.

    ![Step 9.png](../media/image40.png)

9. Click on **Create agent**.

    ![Step 10.png](../media/image37.png)

10. Paste **Rewards-Campaign-Agent** as Agent name and then click on **Create**.

    ![Step 11 Image](../media/image41.png)

11. Select **gpt-4o** from the drop down and paste below following instructions in the **Instructions** section.

    ```
    Apply personalized discounts to customers based on their loyalty information and explain the applicable Black Friday promotional tiers using the provided knowledge sources.
    ________________________________________
    Response Behavior
    •	Generate responses only from the retrieved knowledge and tool outputs. Do not assume or invent any values.
    •	When a customer name is included, respond in a friendly first-person tone and include celebratory emojis such as 🎉, 😊, or 🛍️.
    •	When the internal team asks about discount tiers, provide an average discount range instead of listing every individual percentage.
    •	Ensure the response clearly reflects the loyalty information and discount values retrieved from the knowledge source or tools.
    ________________________________________
    Response Format
    Always return the response in the following JSON format:
    {
    "answer": "<response generated using the knowledge and tool results>",
    "discount_percentage": "<discount value retrieved from the knowledge or tool>"
    }
    ________________________________________
    Content Handling Guidelines
    •	Do not summarize, filter, or remove any important information from the knowledge source.
    •	Responses must strictly follow the information retrieved from the given knowledge only.
    •	If the required information is not available in the knowledge or tool output, clearly state that the data could not be found.

    ```

    ![Step 12 Image](../media/image42.png)

12. Click on **Save** and then click on the back arrow (**⬅**) to create the next Agent.

    ![Step 13 png](../media/image43.png)

13. Click on **Create agent**.

    ![Step 14.png](../media/image37.png)

14. Paste **Inventory-Agent** as Agent name and then click on **Create**.

    ![Step 15 Image](../media/image45.png)

15. Select **gpt-4o** from the drop down and paste below following instructions in the **Instructions** section.

    ```
    You are Inventory check agent,
    •	Your task is to check the inventory status.
    •	When a user asks to check the inventory for a product, send the product name to the Fabric Data Agent tool.
    •	Return the response including inventory levels, inventory status, and location.
    Content Handling Guidelines
    •	Do not generate summaries or remove any data from the response.
    •	The response must come only from the Fabric Data Agent tool output.

    ```

    ![Step 16 Image](../media/image46.png)

17. Click on **Save** and then click on the back arrow (**⬅**) to return.

    ![Step 17.png](../media/image47.png)


### Task 3.2: Attach configured knowledge sources to the agent

1. Click on **Rewards-Campaign-Agent**.

    ![Step 1.png](../media/image48.png)

2. Click on **Add**, then click on **Connect to Foundry IQ**.

    ![Step 2.png](../media/image49.png)

3. Select **srch-foundry-iq-lab** as the Connection, then select **foundry-lab-knowledgebase** and click on **Connect**

    ![Step 3.png](../media/image50.png)

4. Review the connected **Foundry IQ knowledge base**, then click on **Save** and click on **⬅** to configure Foundry IQ knowledge base to another agent.

    ![Step 4.png](../media/image51.png)

5. Click on **Sales-Associate-Agent**.

    ![Step 5.png](../media/image52.png)

6. Click on **Add**, then select **foundry-lab-knowledgebase**.

    ![Step 6.png](../media/image53.png)

7. Review the connected **Foundry IQ knowledge base**, click on **Save** and click on the back arrow (**⬅**).

    ![Step 7.png](../media/image54.png)


### Task 3.3: Implement agent Tool Calling capabilities

1. Click on **Inventory-Agent**.

    ![Step 1.png](../media/image57.png)

2. Under the Tools dropdown,Click on **Add**, then click on **Browse all tools**.

    ![Step 2.png](../media/image58.png)

3. Click on **Fabric Data Agent**, then click on **Add tool**.

    ![Step 3.png](../media/image59.png)

4. Navigate to **Microsoft Fabric**, click on **Workspace** and click on **TechExperience-Lab001**

    ![Step 4.png](../media/image26.png)

5. Click on **IQ_agent**

    ![Step 5.png](../media/image56.png)

6. Copy the **Workspace ID** and the **Artifact ID** from URL

   > You can find the Workspace ID in the URL. It is the unique string between two "/" characters after /groups/.
    
    >You can find the Artifact ID in the URL, it is the unique string inside two / characters after /aiskill/ in your browser window.

    ![Step 6.png](../media/image55.png)

7. Navigate back to Microsoft Foundry, paste **fabriciq_dataagent** as Name, paste the previously copied **Workspace ID** and the **Artifact ID**, then click on **Create**

    ![Step 7.png](../media/image60.png)

8. Review the connected **Foundry Data Agent** tool, click on **Save** and click on **⬅**.

    ![Step 8.png](../media/image61.png)

### What We Learned

- How to create multiple agents with specific roles and instructions for routing and specialized tasks.
- How to implement tool calling by attaching knowledge sources and data agents to agents.
- How to configure agents for product recommendations, rewards campaigns, and inventory checks.

### Next Exercise

In the next exercise, we will learn how to configure multi-agent orchestration and validation using workflows to coordinate between agents.
