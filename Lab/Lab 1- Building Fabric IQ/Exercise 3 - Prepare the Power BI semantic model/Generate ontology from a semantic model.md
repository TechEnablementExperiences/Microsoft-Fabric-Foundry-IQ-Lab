# Prepare the Power BI semantic model and Ontology

## Section 1: Semantic Model

### Task 1.1: Build a Direct Lake semantic model 
1. In your Fabric workspace, click on the **New item** button in the top command bar.
2. In the New item creation pane, use the search bar to type **"Semantic model"**.
3. Select the **Semantic model** card in the search results and click on it to initiate creation.

    ![Semantic Model](../../media/SemanticModel.png)

### Task 1.2: Choose required entities/tables for the semantic model 

1. After cliking **Semantic Model**, you will be prompted to choose the data source. Select **OneLake catalog**.

    ![Source Selection](../../media/SourceSelection.png)

2. Choose the data source within the OneLake catalog, Here, select the **Fabric_IQ** Lakehouse and click on **Connect**.

    ![Lakehouse](../../media/LakeshouseSelection.png)

3. Now, it will redirect to creation of Semantic Model. Provide model name **Fabric_IQ_SM**  and select workspace.

4. In the table selection window, expand each schema and click on **Select all** to include all available tables. Ensure that all tables across all schemas are selected before proceeding, and then click on **Confirm**.

    ![SMcreation](../../media/SMcreation.png)


### Task 1.3: Establish relationships between entities
This task to establish relationships between lakehouse entities within Microsoft Fabric to create a connected, business-friendly data model.

1. In Semantic Model page, click on **Manage relationships** .

    ![Manage Relationship](../../media/SMLoadingTables.png)

2. For creating relationship, click on **New relationship** button at top.

    ![New Relationship](../../media/NewRelationship.png)

3. Select the **store** and **inventory** tables and create a relationship using the **StoreId** column, Select the **cardinality** and **cross-filter direction**, **Enbale** Make this relationship active" and then click on **Save** button.
 
    ![Create Relationship](../../media/CreateRelationship.png)

4. Repeat the process to create all required relationships as shown in the below Image and click on **Close**.

    ![relation](../../media/relation.png)

    More relationships
    
    ![relationcnt](../../media/relationcnt.png)

> **Note**: Alernatively, we can drag and drop the master unique ID from master table to transaction table to get get build relationship page. Choose cardinality, direction, and save.
