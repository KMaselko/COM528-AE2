# Design documentation

This documentation will outline the entire process, design and plan for this project. Relevant diagrams will also be presented to demonstrate in an easier way how the program works.

## Use cases
The program includes some very important functions without which the whole project would not make sense. They were necessary for the program to run without any problems and at least to a small extent to do its work.
These features are:
* Having a user called customer, with the following permissions:
  * Adding items to the cart
  * Purchasing these items
  * Modifying user details
  * Being able to track their order
* Having a user called guest, with the following permissions:
  * Adding items to the cart
  * Creating an account
* Having a user called admin, with the following permissions:
  * Modifying and removing orders
  * Modifying and removing users
  * Modifying, adding and removing products
* Creating orders
* Decrementing from stock when ordered
* Log system with transactions and orders


The use cases of different features in the application:
|Actor|Usage|Response|
|-----|-----|-------|
| Admin | Admin enters logging details in the login webpage | Admin logs into the admin account having the accessability to admin panel |
| Admin | Admin enters admin panel | Admin panel shows up |
| Admin | Admin adds or modifies a category | As expected |
| Admin | Admin adds, modifies or removes a product | As expected |
| Admin | Admin views or removes an order | As expected |
| Customer | Modify user | As expected |
| Customer | Logs out | The user becomes a guest |
| Customer | Purchases products | An order is being created, stock is decreasing |
| Customer | Adds items to the cart | The cart is increasing and awaits the purchase |
| Guest | Adds items to the cart | The cart is increasing but asks to log in to proceed |
| Guest | Creates an account | The accoung is created and the guest becomes a customer |

## Diagrams

### Use Case Diagram
Use Case Diagram shows the exact same process described in the table above but as a drawing for better understanding.
![](/documentation/images/usecase.drawio.png)

### UML Class Diagram
UML Class Diagram describes the process behind the whole project, so called "backend". It shows how different functions and classes have been used to meet the requirements in the application that will make it more readable for everyone, especially for those who do not want to look at the code itself.
![](/documentation/images/class.drawio.png)

## Plan & Design
|Task|Description|
|-----|-----|
| Project Plan | Project plan on GitHub to work out the most important features to create the project |
| Documentation | Documentation of the whole project using markdown in GitHub |
| Use Cases | Use Case Diagram that would explain all the features in the project |
| UML Class Diagram | UML Class Diagram that would explain all the classes and functions in the project |
| Website Design | Website design for creating the frontend with meeting the requirements to the maximum |

## Development process
|Task|Description|
|-----|-----|
| Modules | Connecting different modules and class to make fully functional website |
| Index page (front end) | Creating front end for the index page where every product will be displayed |
| Index page (back end) | Creating back end in Java that would look into the database and get proper variables from it |
| Database (mySQL) | Creating mySQL database using XAMPP and phpMyAdmin to store categories, products, orders and users |
| Shopping cart (back end) | Creating shopping cart webpage to actually display every item that was added to the cart, calculate its prices and stock |
| Login page | Creating login page that is connected to the user table in the database |
| Admin panel | Creating admin panel where the administrator will have the full control over the website |
