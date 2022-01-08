<%@page import="helper.ConnectionProvider"%>
<%@page import="dao.ProductDao"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="./css/style.css"/>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
        <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
        <script src="js/script.js"></script>
        <title>Order Page</title>
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
            <%
                String id = request.getParameter("id");
                ProductDao productDao = new ProductDao(ConnectionProvider.getConnection());
                ResultSet rs = productDao.getProductById(Integer.parseInt(id));
                if (rs.next()) {
            %>
            <div class="row mt-2">
                <div class="col-4 product-box p-2">
                    <div class="product-img">
                        <img src="./img/<%= rs.getString("product_img")%>" class="img-fluid" />
                    </div>
                </div>
                <div class="col-8">
                    <div class="product-title">
                        <h5><%= rs.getString("product_name")%></h5>
                    </div>
                    <div class="product-description">
                        <p><%= rs.getString("description")%></p>
                    </div>
                    <%
                        if (rs.getInt("quantity") > 0) {
                    %>
                    <div class="product-price mb-2">
                        <b class="text-success">In Stock</b> <b><%= rs.getInt("quantity")%></b>
                    </div>
                    <%
                    } else {
                    %>
                    <div class="product-price mb-2">
                        <b class="text-danger">Out Of Stock</b> <b></b>
                    </div>
                    <%
                        }
                    %>
                    <div class="product-price mb-2">
                        <b>Price: £<%= rs.getDouble("price")%></b>
                    </div>
                    <div class="product-price">
                        <input type="button" onclick="add_to_cart(<%= rs.getInt("id")%>, '<%= rs.getString("product_name")%>', <%= rs.getDouble("price")%>)" class="btn btn-outline-primary" value="Add to trolley" />
                    </div>
                </div>
            </div>
            <%
                }
            %>

            <hr>

            <%
                ProductDao productDao2 = new ProductDao(ConnectionProvider.getConnection());
                ResultSet like = productDao2.getProductLike(rs.getString("product_name"), rs.getInt("id"));
                if (like != null) {
            %>

            <h3>Related Products</h3>
            <div class="row mt-2">
                <%
                    while (like.next()) {
                %>
                <div class="col-4 product-box p-2">
                    <div class="product-img">
                        <a href="order.jsp?id=<%= like.getInt("id")%>"><img src="./img/<%= like.getString("product_img")%>" class="img-fluid" /></a>
                    </div>
                    <div class="product-title">
                        <a href="order.jsp?id=<%= like.getInt("id")%>"><h5><%= like.getString("product_name")%></h5></a>
                    </div>
                    <div class="product-price mb-2">
                        <b>$<%= like.getDouble("price")%></b>
                    </div>
                    <div class="product-price">
                        <input type="button" onclick="add_to_cart(<%= like.getInt("id")%>, '<%= like.getString("product_name")%>', <%= like.getDouble("price")%>)" class="btn btn-outline-primary" value="Add to trolley" />
                    </div>
                </div>
                <%
                    }
                %>
            </div>
            <%
                }
            %>

            <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
            <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
            <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
    </body>
</html>