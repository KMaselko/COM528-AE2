# Test plan document

## As a guest

|Test plan|Action|Expected result|Result given|Pass or Fail |
|---------|------|-----------------|--------------|--------------|
| 1 | Enter the proper URL | Website loads with no issue | As expected | Pass |
| 2 | Add items to the cart | Items have been added | As expected | Pass |
| 3 | Try to buy products | Needs to be logged in to proceed | As expected | Pass |
| 4 | Enters admin panel | Throws a login webpage | As expected | Pass |

## As a user
|Test plan|Action|Expected result|Result given|Pass or Fail |
|---------|------|-----------------|--------------|--------------|
| 1 | Try to buy products | Proceeds | As expected | Pass |
| 2 | Proceed the payment | Payment goes through the bank application using REST API | The payment does not go through | Fail |
| 3 | Enters admin panel | Throws a login webpage because user does not have admin permissions | As expected | Pass |
| 4 | Review transactions | Customer is able to review their orders | Only admin can do that | Fail |

## As an administrator
|Test plan|Action|Expected result|Result given|Pass or Fail |
|---------|------|-----------------|--------------|--------------|
| 1 | Enters admin panel | Shows an admin panel | As expected | Pass |
| 2 | Modify products | Changes products values | As expected | Pass |
| 3 | Delete products | Completely removes items from the database | As expected | Pass |
| 4 | Add a new product | Adds a new product to the database | As expected | Pass |
| 5 | Add a new category | Adds a new category to the database | As expected | Pass |
| 6 | Edit an existing category | Changes the name of the category, it applies for already existing products | As expected | Pass |
| 7 | Delete a category when no products assigned to that category | Removes the category | As expected | Pass |
| 8 | Delete a category when there are products assigned to that category | Throws an error that it is not possible unless the products will be removed first | As expected | Pass |
| 9 | Check current orders | Shows order that has been made by a customer | As expected | Pass |
| 10 | Delete an order | Deletes an order from the database | As expected | Pass |

## As a system
|Test plan|Action|Expected result|Result given|Pass or Fail |
|---------|------|-----------------|--------------|--------------|
| 1 | Purchase an item | Decrement the stock of that item | Does not decrement the stock | Fail |
| 2 | Deactivate the user | The admin is able to deactivate a user | Is not implemented | Fail |
| 3 | Orders bar from the admin menu | Orders are stored in the system | As expected | Pass |
| 4 | Orders bar from the admin menu | Transactions are stored in the system | Not implemented | Fail |
| 5 | Failed transactions | They should be stored in the systems | Transactions are not implemented | Fail |
