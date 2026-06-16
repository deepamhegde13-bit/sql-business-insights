# E-Com Schema Recon

## Table Inventory
1. Addresses
2. Attribution Campaigns
3. Attribution Touches
4. Brands
5. Categories
6. Collection Products
7. Collections
8. Consents
9. Coupons
10. Customer Addresses
11. Customer Segments
12. Customers
13. Devices
14. Experiment Assignments
15. Experiment Variants
16. Experiments
17. Inventory Items
18. Inventory Movements
19. Loyalty Accounts
20. Loyalty Transactions
21. Marketing Campaigns
22. Notifications
23. Order Items
24. Order Refunds
25. Order Status History
26. Orders
27. Payment Intents
28. Payment Methods
29. Payment Transactions
30. Price Lists
31. Prices
32. Product Images
33. Product Reviews
34. Product Variants
35. Products
36. Promotion Rules
37. Promotions
38. Refunds
39. Return Items
40. Return Reasons
41. Return Requests
42. Segment Memberships
43. Session Channels
44. Session Events
45. Sessions
46. Shipments
47. Shipping Carriers
48. Shipping Methods


## Important Tables
| Table Name         | Columns | Rows    | Primary Key       | Foreign Key                                      | Note                                                                                   |
|--------------------|---------|---------|------------------|-------------------------------------------------|----------------------------------------------------------------------------------------|
| customers          | 20      | 10,000  | customer_id       | -                                               | connects "consents", "orders", "sessions", "notifications", "loyalty accounts" with customer_id as FK |
| orders             | 18      | 40,000  | order_id          | customer_id, session_id, cart_id, price_list_id | connects "shipments", "order items", "refunds", "loyalty transactions" with order_id as FK |
| order_items        | 6       | 81,806  | -                 | order_id, variant_id                            | no connections                                                                         |
| sessions           | 12      | 100,000 | session_id        | customer_id, device_id                          | connects "attribution_touches", "orders", "session_events", "experiment_assignments" with session_id as FK |
| categories         | 3       | 18      | category_id       | parent_id                                       | connects "products", "promotion rules" with category_id as FK                          |
| products           | 7       | 4,000   | product_id        | brand_id, category_id                           | connects "collection products", "product reviews",  "promotion rules" with product_id as FK |
| attribution_touches| 10      | 100,000 | touch_id          | session_id                                      | no connections                                                                         |
| devices            | 5       | 85,168  | device_id         | -                                               | connects "sessions" with device_id as FK                                               |
| payment_intents    | 6       | 40,000  | payment_intent_id | order_id, payment_method_id                     | connects "payment_transactions" with payment_intent_id as FK                           |
| shipments          | 8       | 32,089  | shipment_id       | order_id, carrier_id, shipment_method_id        | no connections                                                                         |


## Value Distributions
1.addresses:
| Country        | City Count | States |
|----------------|------------|--------|
| United States  | 2,071      | 10     |
| India          | 13,929     | 21     |

2.attribution_touches:
| utm_source | count  |
|------------|--------|
| affiliate  | 14,437 |
| direct     | 13,992 |
| google     | 14,259 |
| linkedin   | 14,401 |
| meta       | 14,475 |
| newsletter | 14,078 |
| youtube    | 14,358 |

| Channel   | Count  |
|-----------|--------|
| Affiliate | 6,030  |
| Email     | 6,995  |
| Organic   | 39,924 |
| Paid      | 34,905 |
| Referral  | 12,146 |

3.coupons:
| discount_type | count |
|---------------|-------|
| BOGO          | 5     |
| fixed         | 8     |
| free_shipping | 8     |
| percent       | 29    |
*Note: All are active coupons*

4.customer_segments:
| Segment Name   |
|----------------|
| Active Buyer   |
| At Risk        |
| Big Spender    |
| Champion       |
| Churned        |
| Coupon Hunter  |
| Loyal          |
| New Customer   |
| Premium        |
| Window Shopper |

5.customers:
| gender | count |
|--------|-------|
| NULL   | 213   |
| Female | 4,736 |
| Other  | 227   |
| Male   | 4,824 |

| country        | count |
|----------------|-------|
| Empty String   | 500   |
| NULL           | 200   |
| N/A            | 300   |
| India          | 7,641 |
| United States  | 1,359 |

| lyfecycle_stage  | count |
|------------------|-------|
| Active           | 4,869 |
| At Risk          | 3,903 |
| New              | 1,200 |
| Churned          | 28    |

| utm_source | count |
|------------|-------|
| Affiliate  | 1,446 |
| Direct     | 1,424 |
| Google     | 1,395 |
| LinkedIn   | 1,496 |
| Meta       | 1,421 |
| Newsletter | 1,422 |
| YouTube    | 1,396 |

| Channel   | Count |
|-----------|-------|
| Affiliate | 587   |
| Email     | 708   |
| Organic   | 4,023 |
| Paid      | 3,490 |
| Referral  | 1,192 |

6.devices:
| device_type | count  |
|-------------|--------|
| desktop     | 21,168 |
| mobile      | 61,466 |
| tablet      | 2,534  |

7.experiments:
| status    | count |
|-----------|-------|
| NULL      | 1     |
| concluded | 4     |
| running   | 1     |

8.loyalty_accounts:
| tier     | count |
|----------|-------|
| bronze   | 1,646 |
| gold     | 365   |
| platinum | 97    |
| silver   | 892   |

9.notifications:
| channel | count | status    | count |
|---------|-------|-----------|-------|
| email   | 5,334 | delivered | 6,782 |
| push    | 513   | failed    | 74    |
| sms     | 1,009 |           |       |

10.orders:
| status     | count  |
|------------|--------|
| cancelled  | 2,178  |
| delivered  | 19,779 |
| DELIVERED  | 200    (total - 19,979) |
| packed     | 3,887  |
| paid       | 3,946  |
| placed     | 1,897  |
| shipped    | 7,715  |
| Shipped    | 150    |
| SHIPPED    | 248    (total - 8,113) |

11.payment_intents:
| status    | count  |
|-----------|--------|
| failed    | 1,866  |
| succeeded | 38,134 |

12.payment_transactions:
| status    | count  |
|-----------|--------|
| failed    | 1,900  |
| succeeded | 38,134 |

13.payment_methods:
| payment_methods |
|-----------------|
| Card            |
| COD             |
| Netbanking      |
| UPI             |
| Wallet          |

14.promotions:
| discount_type | count |
|---------------|-------|
| fixed         | 8     |
| percent       | 12    |

15.refund:
| status    | count |
|-----------|-------|
| failed    | 13    |
| initiated | 20    |
| succeeded | 227   |

16.return_requests:
| status     | count |
|------------|-------|
| approved   | 308   |
| picked_up  | 309   |
| received   | 310   |
| refunded   | 260   |
| requested  | 416   |

17.shipments:
| status    | count  |
|-----------|--------|
| delivered | 20,043 |
| shipped   | 12,046 |


## Data Quality Checks
- Orphan records: sessions table has 34,751 orphan customer_id records.
- Null values: (gender column in customers), (country column in customers), (status column in experiments), (reason column in order_status_history), 
- Duplicate values: orders table has duplicate status such as "DELIVERED", "delivered", "shipped", "Shipped", "SHIPPED"


## Surprises
1. Status column in orders table has duplicate records.
2. Variant_name in experiment_variants has both lower case and first letter upper case names
3. Table -product_variants has NULL values in multiple columns. (not able to get output - showing error)

## Mermaid ER Diagram
```mermaid
erDiagram
    customers ||--o{ orders : "places"
    customers ||--o{ sessions : "has"
    customers ||--o{ notifications : "receives"
    customers ||--o{ loyalty_accounts : "owns"

    orders ||--|{ order_items : "contains"
    orders ||--o{ shipments : "includes"
    orders ||--o{ refunds : "has"
    orders ||--o{ loyalty_transactions : "generates"
    orders ||--o{ payment_intents : "creates"

    order_items }o--|| products : "references"

    sessions ||--o{ attribution_touches : "records"
    sessions ||--o{ session_events : "tracks"
    sessions ||--o{ experiment_assignments : "assigns"
    sessions ||--|| devices : "uses"

    categories ||--o{ products : "classifies"
    categories ||--o{ promotion_rules : "applies"

    products ||--o{ collection_products : "groups"
    products ||--o{ product_reviews : "reviewed"
    products ||--o{ promotion_rules : "eligible"

    payment_intents ||--o{ payment_transactions : "linked"

    shipments }o--|| carriers : "handled by"
    shipments }o--|| shipment_methods : "via"
