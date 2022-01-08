<%@page import="entities.Product"%>
<%@page import="java.util.ArrayList"%>
<%@page import="helper.ConnectionProvider"%>
<%@page import="dao.ProductDao"%>
<%@page import="java.sql.*"%>
<%@page import="java.net.DatagramSocket"%>
<%@page import="java.net.InetAddress"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="./css/style.css"/>
        <link rel="stylesheet" href="./css/style.css"/>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
        <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
        <script src="js/script.js"></script>
        <title>Shopping Cart System</title>
    </head>
    <body>
        <div class="container mt-2">
            <div class="row">
                <div class="col-1">
                    <a href="index.jsp"><i class="far fa-home" style="font-size: 30px;"></i></a>
                </div>
                <div class="col-9">
                    <form action="" method="post">
                        <div class="input-group">
                            <input type="search" class="form-control rounded" placeholder="Search" aria-label="Search"
                                   aria-describedby="search-addon" />
                            <button type="button" class="btn btn-outline-primary">search</button>
                        </div>
                    </form>
                </div>
                <div class="col-1">
                    <a href="profile.jsp"><i class="far fa-user-circle" style="font-size: 30px;"></i></a>
                </div>
                <div class="col-1">
                    <a href="cart.jsp"><i class="far fa-shopping-cart" style="font-size: 30px;"></i></a> <span class="text-danger cart-items"></span>
                </div>
            </div>
        </div>
        <hr class="container">

        <div class="container">
            <div class="row mt-2">
                <%
                    ProductDao productDao = new ProductDao(ConnectionProvider.getConnection());
                    ResultSet rs = productDao.getAllProducts();
                    if (rs != null) {
                        while (rs.next()) {
                %>
                <div class="col-4 product-box p-2">
                    <div class="product-img">
                        <a href="order.jsp?id=<%= rs.getInt("id")%>"><img src="./img/<%= rs.getString("product_img")%>" class="img-fluid" /></a>
                    </div>
                    <div class="product-title">
                        <a href="order.jsp?id=<%= rs.getInt("id")%>"><h5><%= rs.getString("product_name")%></h5></a>
                    </div>
                    <div class="product-price mb-2" style="padding-bottom: 10%;">
                        <b>£<%= rs.getDouble("price")%></b>
                    </div>
                    <div class="product-price" style="position: absolute; bottom: 5px;">
                        <input type="button" onclick="add_to_cart(<%= rs.getInt("id")%>, '<%= rs.getString("product_name")%>', <%= rs.getDouble("price")%>)" class="btn btn-outline-primary" value="Add to trolley" />
                    </div>
                </div>
                <%
                        }
                    }
                %>
            </div>
        </div>


        <script
            src="https://code.jquery.com/jquery-3.4.1.min.js"
            integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
        crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
    </body>
</html>