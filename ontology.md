 ### Hands-on Lab. Creating an Ontology from a Semantic Model in Microsoft Fabric

### Manually Run "1-ML Solution-Financial Forecasting-AutoML, 2-Customer 360 Insights – Segmentation" Notebooks.

1. In the Power BI service, click on **Workspaces** and select the current working workspace.

    ![Select workspace](media/power-bi-5.png)

2. Click on **Generate Realtime data** notebook.

    ![Select notebook](media/notebook2.png)

3. Ensure that the **Environment** is selected, then click **Run all**.

    ![Run notebook](media/notebook1.png)

>**📝 Note:** The above Notebook will generate only 100 records per run, if you want more data, schedule the notebook accordingly.

![](media/thermostat14.png)

![](media/thermostat13.png)



1. In your Fabric workspace, click on the **New item** button in the top command bar.

![Step 1.png](./media/Step1.png)

2. In the New item creation pane, use the search bar to type **"Semantic model"**.

![Step 2.png](./media/Step2.png)

3. Select the **Semantic model** card in the search results and click on it to initiate creation.

![Step 3.png](./media/Step3.png)

4. You will be prompted to choose the data source. Select **OneLake catalog**.

![Step 4 Image](./media/Step4.png)

5. Choose the data source within the OneLake catalog, Select the **lakehouse_Ontology...** Lakehouse and click on **Connect**.

![Step 5 Image](./media/Step5.png)

6.  In the creation dialog, Enter `zava_semantic_model` as name for the semantic model, Select the `ZavaWorkspace-....` workspace and Click on **Select all** fot tables and then Click on **Confirm** button.

![Step 7 Image](./media/Step7.png)

7. Click on Manage relationships.

![Step 11 Image](./media/11.png)

8. Click on New relationship.

![Step 11 Image](./media/12.png)

9. Select the **store** and **inventory** tables and create a relationship using the **StoreId** column, Select the **cardinality** and **cross-filter direction**, **Enbale** Make this relationship active" and then click on **Save** button.
 

![Step 11 Image](./media/13.png)

10. Repeat the process to create all required relationships as shown in the below Image and click on **Close**.

![Step 11 Image](./media/17.png)

11. Click on **Generate Ontology**.

![Step 11 Image](./media/18.png)

12. Select your Fabric workspace and a paste **zava_ontology** in the **Name** field and then click on **Create** button.

![Step 11 Image](./media/19.png)

13. Click on **inventory** entity type.

![Step 11 Image](./media/21.png)

14. In the **Entity type configuration** pane, click on **Bindings** and Click on **Add data to entity type**.

![Step 11 Image](./media/22.png)

15. Click on **Zava-KQL-DB** Eventhouse and click on **Connect**.

![Step 11 Image](./media/24.png)

16. Select **inventory_telemetry** table and click on **Next** button.

![Step 11 Image](./media/26.png)

17. Select **LastRestockDateTime** for **Source data timestamp column** filed, select Static and Timeseries columns and then click on **Save** button.

![Step 11 Image](./media/30.png)

18. Verify the Properties.

![Step 11 Image](./media/31.png)

19. Repeat **Step 13 - 18**.
    - In Step 13 click on **device** Entity type.
    - In Step 16 Select **temperature_telemetry** table.
    - In Step 17 Select **Timestamp** for **Source data timestamp column** filed.

![Step 11 Image](./media/32.png)

20. Check the different entity types and verify the key. If no key exists, click **Add entity type key**, 

![Step 11 Image](./media/33.png)

21. Select the key column, and then click **Save**.

| Entity        | Key                     |
|---------------|--------------------------|
| sales         | SaleId                  |
| device        | DeviceId                |
| inventory     | InventoryId             |
| product       | ProductId               |
| campaigndata  | PRODUCTID               |
| storemanager  | CombinedID              |
| shiftschedule | ShiftID and StoreID     |
| store         | StoreId                 |
|               |                         |

![Step 11 Image](./media/34.png)

22. After adding the key, check each and every entity. Click on the **relationships** in the graph and set the **source** table and **destination** table as per the name. For example, if the name is **campaigndata_has_product**, the source is **campaigndata** and the destination is **product**. 

![](./media/37.png)

23. Scroll down and then add the **Source column** for both **Source entity type** and **Target entity type**, which is the **Entity type key property** and then click on **Apply**.

![](./media/38.png)

24. Repeat steps 22 and 23 for each and every entity.

25. Click on any entity type.

![Step 11 Image](./media/21.png)

23. Click on "Entity type overview".

![Step 11 Image](./media/36.png)

24. Click on **Last 30 days - Automatic - Average** and select **Time range** as **Last 24 hours** and then click on **Apply**.

![Step 11 Image](./media/39.png)

### Exercise 4: Exposing Ontology using AI Foundry

## **Task 4.1:** Creating a Data Agent with Ontology as a data source  

1. Click on **Workspaces** and click on **ZavaWorkspace-...**.

![Step 11 Image](./media/dataagent1.png)

2. Click on **+ New item**, Search for **Data Agent** and then click on it.

![Step 11 Image](./media/dataagent2.png)

3. Paste **Ontology_DataAgent** in the **Create data agent** field and click on **Create** button.

![Step 11 Image](./media/dataagent3.png)

4. Click on **Add a data source**.

![Step 11 Image](./media/dataagent4.png)

5. click on **zava_ontology** and then click on **Add**.

![Step 11 Image](./media/dataagent5.png)


- **Task 4.2:** Validating the Data Agent using natural language queries

1. Paste the question below into the Data Agent and observe the response:

```What are the top operational issues impacting store sales right now, and what actions should we take?” ```

![Step 11 Image](./media/dataagent6.png)

2. Review the response..

![Step 11 Image](./media/dataagent7.png)

3. Paste the question below into the Data Agent and observe the response:

```Which stores are underperforming, and what are the likely reasons? ```

![Step 11 Image](./media/dataagent8.png)

4. Review the response.

![Step 11 Image](./media/dataagent9.png)

5. In the same way, paste the questions below into the Data Agent and observe the responses:

```
Which campaigns delivered the highest ROI, and how can we improve upcoming campaigns?
```

```
Which products are driving revenue and margin, and where do we have inventory risks?
```

```
How should we optimize staffing by shift to reduce labor cost without hurting sales?
```

```
Create a daily business performance summary.
```

```
Detect anomalies across sales, inventory, and staffing.
```
