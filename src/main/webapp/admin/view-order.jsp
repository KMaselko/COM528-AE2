<%@page import="dao.UserDao"%>
<%@page import="dao.OrderDao"%>
<%@page import="entities.User"%>
<%@page import="helper.ConnectionProvider"%>
<%@page import="dao.ProductDao"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <%
        User user = (User) session.getAttribute("user");
        if (user == null || user.getRole().equals("normal")) {
            response.sendRedirect("../login.jsp");
        }
    %>


    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="../admin/css/style.css"/>
        <link rel="stylesheet"
              href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
        <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

        <title>Order Details Page</title>
    </head>
    <body>
        <jsp:include page="navbar.jsp" />
        <br>

        <div class="container-fluid">

            <%
                String id = request.getParameter("view");
                OrderDao orderDao = new OrderDao(ConnectionProvider.getConnection());
                ProductDao productDao = new ProductDao(ConnectionProvider.getConnection());
                UserDao userDao = new UserDao(ConnectionProvider.getConnection());
                ResultSet rs = orderDao.getOrderById(Integer.parseInt(id));
                ResultSet u;
                ResultSet p;
                if (rs.next()) {
                    u = userDao.getUserById(rs.getInt("user_id"));
                    p = productDao.getProductById(rs.getInt("product_id"));
                    if (u.next() && p.next()) {
            %>
            <div class="row">
                <jsp:include page="sidebar.jsp" />

                <div class="col-9">
                    <h1>Order Details</h1>
                    <div class="row">
                        <div class="col-4">
                            <div>
                                <img src="../img/<%= p.getString("product_img")%>" class="img-fluid border p-2" />
                            </div>
                        </div>
                        <div class="col-8">
                            <div>
                                <h5><%= p.getString("product_name")%></h5>
                                <p><%= p.getString("description")%></p>
                            </div>
                            <div class="row">
                                <div class="col">   
                                    <p>Product Code</p>
                                </div>
                                <div class="col">   
                                    <p><%= p.getString("product_uid")%></p>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col">   
                                    <p>Quantity</p>
                                </div>
                                <div class="col">   
                                    <p><%= rs.getInt("quantity")%></p>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col">   
                                    <p>Name</p>
                                </div>
                                <div class="col">   
                                    <p><%= u.getString("name")%></p>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col">   
                                    <p>Email</p>
                                </div>
                                <div class="col">   
                                    <p><%= u.getString("email")%></p>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col">   
                                    <p>Phone</p>
                                </div>
                                <div class="col">   
                                    <p><%= u.getString("phone")%></p>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col">   
                                    <p>Address</p>
                                </div>
                                <div class="col">   
                                    <p><%= u.getString("address")%></p>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col">   
                                    <p>Total Amount</p>
                                </div>
                                <div class="col">   
                                    <p>$<%= p.getDouble("price") * rs.getInt("quantity")%></p>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
            <%
                    }
                }
            %>
        </div>

    </body>
</html>