 ## Observability, Evaluation & Guardrails

This lab would be a hands-on Lab to give you a better idea on how to use Guardrails and evaluate your agents.

### Task 5.1: Activate built-in guardrails by enforcing behavioral policies, prompt injection protection, and output moderation, requiring pre-deployment evaluation gates for new agents.

1. From the left pane, click on **Guardrails** and then click on **Create**.

    ![Step 1.png](../../media/image80.png)

2. Under the **Controls** section, select the **Risk Type** checkbox for the dropdowns : **Jailbreak**, **Content Safety** and **Protected Materials**, and click **Next**.

    ![Step 2.png](../../media/image81.png)

3. Under the section **Select agents and models**, click on **Add agents**, select the **Name** checkbox to include all agents, then click on **Save**.

    ![Step 3.png](../../media/image82.png)

4. Click on **Next**.

    ![Step 4.png](../../media/image83.png)

5. Under the **Review** section, paste `Guardrail11` as Guardrails name, Click on **Submit**.

    ![Step 5.png](../../media/image84.png)


### Task 5.2: Implement an evaluation methodology by defining success metrics, running offline batch evaluations, applying rubric and safety checks, and using telemetry for ongoing online evaluation and progressive rollout 

1. Click on **Evaluations** and then click on **Create**.

    ![Step 1.png](../../media/image85.png)

2. Under the **Target: Agent** section, select the **Supervisor** agent, then click on **Next**.

    ![Step 2.png](../../media/image86.png)

3. Under the section **Data**, click on **Generate**. leave other values as default and type `10` for **Number of rows**, then click on **Confirm**.

    ![Step 3.png](../../media/image87.png)

4. Click on **Next**.

    ![Step 4.png](../../media/image88.png)

5. Under the **Criteria** section, click on **Next**.

    ![Step 5.png](../../media/image89.png)

6. Under the **Review** section, enter `eval-7gthxnri` as **Evaluation name** and click on **Submit**.

    ![Step 6.png](../../media/image90.png)

    > Note: It might take few seconds to load.

7. Review the **Evaluation runs** and **Evaluators**.

    ![Step 7.png](../../media/image91.png)