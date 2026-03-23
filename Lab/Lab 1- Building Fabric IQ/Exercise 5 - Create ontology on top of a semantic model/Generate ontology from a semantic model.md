# Generating Onntology from Semantic Model
Build an ontology from the Semantic Model to map datasets into governed entities and relationships, forming the foundation for Data Agents and contextual analytics.

## Section 1: Ontology
Ontology IQ provides a business-centric semantic layer that defines entities, relationships, and context, enabling intuitive data discovery and accurate natural language insights.

### Task 1.1: Creating Ontology
This task to build Ontology on top of semantic model.

1. After built relationship in semantic model, click on **Generate Ontology** icon at top right menu.

    ![Step 11 Image](../../media/SelectOntology.png)

2. Select your Fabric **Workspace** and provide the Ontology **Name** field and then click on **Create** button.

    ![Step 11 Image](../../media/GenerateOntology.png)

3. In Ontology page, we can see all the entities published. Click on **inventory** entity type.

    ![Step 11 Image](../../media/Entity.png)

4. In the **Entity type configuration** pane, click on **Bindings** and Click on **Add data to entity type**.

    ![Step 11 Image](../../media/EntityTypeConfig.png)

5. Click on **Retail_EventHouse** Eventhouse and click on **Connect**.

    ![Step 11 Image](../../media/EventhouseSelection.png)

6. Select **inventory** table and click on **Next** button.

    ![Step 11 Image](../../media/RTITable1.png)

7. Select **LastRestockDateTime** for **Source data timestamp column** filed, select Static and Timeseries columns and then click on **Save** button.

    ![Step 11 Image](../../media/RTITableMapping1.png)

8. Verify the Properties.

    ![Step 11 Image](../../media/PropertyVerify1.png)

9. Repeat above steps if you want to bind other real time data to any entity.

    ![AllProperty1](../../media/AllProperty1.png)

10. Check the different entity types and verify the key. If no key exists, click **Add entity type key**, 

    ![Step 11 Image](../../media/EntityTypekey.png)

11. Select the key column, and then click **Save**.

    | Entity        | Key                      |
    |---------------|--------------------------|
    | feedback      | feedbackid               |
    | shiftschedule | ShiftID                  |
    | thermostart   | DeviceId                 |
    | Store         | StoretId                 |
    | webtraffic    | SessionID                |
    | onlinesales   | TransactionID            |
    | product       | productID                |
    | offlinesales  | TransactionID            |
    | inventory     | ProductID                |
    | campaigns     | ProductID                |
    | storemanager  | CombinedID               |
    | customer      | customerID               |
    | clickstream   | SessionID                |

12. After adding keys for all entities, validate the relationships between them.Click on any **entity** in the graph view. You will notice that **relationships are automatically created** between related entities.Click on any **relationship line/name** in the graph (for example, **campaigndata_has_product**).  

13. Once selected, the **Relationship configuration** panel will open on the right side, where you can View the **Source entity** and View the **Target entity** and  Understand how the entities are connected (join columns)
     
     For example, if the relationship name is **campaigns_has_product**:
      - **Source** → campaigns  
      - **Target** → product  

    Verify that all relationships are correctly mapped based on the entity names and data.

      ![Rel Config](../../media/RelationshipConfiguration1.png)

14. If a relationship is not created automatically, select the required **entity** from the Entity Types list, then click on **Add relationship** from the top menu. In the dialog box, enter a **relationship name**, select the appropriate **Source entity type** and **Target entity type**, and then click on **Add relationship type** to create the relationship.

     ![Relationcnfgr2](../../media/Relationcnfgr2.png)

15. In the Relationship configuration panel, select the appropriate **Workspace**, **Lakehouse**, and **Table**, then map the **Source column (CustomerID)** to the corresponding **Target entity key column (CustomerID)**, ensuring both sides are correctly linked, and finally click on **Create** to establish the relationship.

    ![Relationshipcnfg3](../../media/Relationshipcnfg3.png)

16. Repeat above two steps for each and every entity to create proper relationship.

17. Click on any entity type.

    ![Step 11 Image](../../media/Entity.png)

18. Click on "Entity type overview".

    ![Step 11 Image](../../media/EntityType.png)

19. Click on **Last 30 days - Automatic - Average** and select **Time range** as **Last 24 hours** and then click on **Apply**.

    ![Step 11 Image](../../media/TimeRange.png)

20. Now Ontology IQ is ready for all the entities for business usage. We can click any entity to check its overview. Below I have select **Product**

    ![Step 11 Image](../../media/EntityOverview.png)