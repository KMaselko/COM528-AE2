# Shopping Cart - Assignment 2
Shopping cart is a simple web application written in Java using Netbeans. This program uses the Tomcat server and is connected to the database using MySQL. The database contains information about users, products and orders.
The main function of this application is to provide an online store-like service. The user is to be able to view the products available in the store, add them to the cart and ultimately purchase them. In turn, the admin should be able to add products to the stock, edit or delete them. He will also be able to manage the users.

## Notes

- Design documentation can be found [here](documentation/design.md)
- Test plan can be found [here](documentation/test_plan.md)
- The project is using the APACHE license V2 which can be found [here](./LICENSE) 


This project uses various technologies learned during the semester to meet the requirements for creating a functional program. These are:

- HTML, CSS and JavaScript to create a front end that is a friendly looking website for all users
- JSP so that the website can display the back end of the page. In other words, JSP allows you to add interactivity and immersion
- Java, which is the back end, allows you to write an entire program
- Tomcat that allows you to create a virtual server
- Maven that allows to install packages remotely
- MySQL which saves the entire database for this program

The programs that helped in creating this project are:
- Netbeans
- XAMPP
- Git
- phpMyAdmin

## Requirements
- Java JDK 15
- Netbeans (recommended)
- Any web browser (Google Chrome recommended)
- Apache Tomcat 9

## Configuration
### Setting up a database
After cloning the repository, you will need the XAMPP program to run the database. This program can be downloaded [here](https://www.apachefriends.org/download.html).
After installation, you should turn on the Apache and MySQL server (port 3306). By clicking on Admin next to MySQL you will be redirected to phpMyAdmin localhost where you can create a new database - name it `shopping_cart`. By clicking on this database you will be able to import SQL query. You will find this file in the repository folder; it is called `shopping_cart.sql`. After importing this query, 4 tables should be created: `categories`, `orders`, `products` and `users`. You're ready to start the project.
### Setting up a project
To run a project, open this folder with Netbeans and press run. After loading, you will see a blank page because you don't have any data in the database.
Let's start with creating the first user, i.e. the admin:
User Icon -> Register -> Fill in the form and press Register again -> using phpMyAdmin, change the role of the user from normal to admin.

Then, to add products, you need to get to the administration panel, to do it, enter http://localhost:8080/ShoppingCart/admin in the URL.
From there, you must first add the appropriate categories and then the items that belong to the categories. Remember to download the appropriate pictures for your products.
