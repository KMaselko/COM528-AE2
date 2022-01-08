<%@page import="entities.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="./css/style.css"/>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
        <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
        <title>Order Page</title>
    </head>
    <body>
        <%
            User user = (User) session.getAttribute("user");
            if (user == null) {
                response.sendRedirect("login.jsp");
            }
        %>
        <div class="container mt-2">
            <div class="row">
                <div class="col-1">
                    <a href="index.jsp"><i class="far fa-home" style="font-size: 30px;"></i></a>
                </div>
                <div class="col-9">
                    <h3>Shopping Cart System / User Profile</h3>
                </div>
                <div class="col-1">
                    <a href="profile.jsp"><i class="far fa-user-circle" style="font-size: 30px;"></i></a>
                </div>
                <div class="col-1">
                    <a href="cart.jsp"><i class="far fa-shopping-cart" style="font-size: 30px;"></i></a> <span class="text-danger">0</span>
                </div>
            </div>
        </div>
        <hr class="container">

        <div class="container">
            <%
                if (user != null) {
            %>
            <h3>Personal Information</h3><hr>
            <div class="row">
                <div class="col">
                    <div style="width: 600px; margin: auto; border: 1px solid darkgray; padding: 10px;">
                        <div class="row">
                            <div class="col-6">
                                <b>Name:</b>
                            </div>
                            <div class="col-6">
                                <span><%= user.getName()%></span>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-6">
                                <b>Email</b>
                            </div>
                            <div class="col-6">
                                <span><%= user.getEmail()%></span>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-6">
                                <b>Phone</b>
                            </div>
                            <div class="col-6">
                                <span><%= user.getPhone()%></span>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-6">
                                <b>Address</b>
                            </div>
                            <div class="col-6">
                                <span><%= user.getAddress()%></span>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-6">
                                <a href="LogoutServlet">Logout</a>
                            </div>
                            <div class="col-6">
                                <a href="edit-profile.jsp?id=<%= user.getId() %>">Edit Profile</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <%
                }
            %>

        </div>

        <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
    </body>
</html>