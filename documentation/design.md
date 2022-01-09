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
| Admin |  |  |
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |
