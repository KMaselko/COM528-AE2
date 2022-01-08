<%@page import="entities.User"%>
<%@page import="dao.UserDao"%>
<%@page import="dao.ProductDao"%>
<%@page import="dao.OrderDao"%>
<%@page import="helper.ConnectionProvider"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="../admin/css/style.css"/>
        <link rel="stylesheet"
              href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
        <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

        <title>Orders Page</title>
    </head>
    <body>
        <%
            User admin = (User) session.getAttribute("user");
            if (admin == null || admin.getRole().equals("normal")) {
                response.sendRedirect("../login.jsp");
            }
        %>
        <jsp:include page="navbar.jsp" />
        <br>

        <div class="container-fluid">

            <div class="row">
                <jsp:include page="sidebar.jsp" />

                <div class="col-9">
                    <h1><i class="fa fa-user"></i> All Orders</h1>
                    <a href="orders.jsp"></a>
                    <div class="breadcrumb">
                        <li><a href="index.jsp"><i class="fa fa-tachometer"></i> Dashboard</a></li>
                        <li class="active pl-2"><i class="fa fa-user"></i> All Orders</li>
                    </div>
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th scope="col">#</th>
                                <th scope="col">User Name Name</th>
                                <th scope="col">Product Name</th>
                                <th scope="col">Quantity</th>
                                <th scope="col">Price</th>
                                <th scope="col">View</th>
                                <th scope="col">Delete</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                OrderDao orderDao = new OrderDao(ConnectionProvider.getConnection());
                                ProductDao productDao = new ProductDao(ConnectionProvider.getConnection());
                                UserDao userDao = new UserDao(ConnectionProvider.getConnection());
                                ResultSet rs = orderDao.getAllOrders();
                                int count = 1;
                                if (rs != null) {
//                                    ResultSet set = orderDao.getOrderByUserIdAndProductId(rs.getInt("user_id"), rs.getInt("product_id"));
                                    while (rs.next()) {
                                        ResultSet product = productDao.getProductById(rs.getInt("product_id"));
                                        ResultSet user = userDao.getUserById(rs.getInt("user_id"));
                                        if (product.next() && user.next())
                            %>
                            <tr>
                                <th scope="row"><%= count %></th>
                                <td><%= user.getString("name")%></td>
                                <td><%= product.getString("product_name")%></td>
                                <td><%= rs.getInt("quantity")%></td>
                                <td><%= product.getDouble("price")%></td>
                                <td><a href="view-order.jsp?view=<%= rs.getInt("id")%>"><i class="fa fa-eye"></i></a></td>
                                <td>
                                    <form id="delete-order-form" action="DeleteOrderServlet" method="post">
                                        <input type="text" name="order_id" value="<%= rs.getInt("id")%>" hidden />
                                        <button type="submit" class="btn-outline-primary"><i class="fa fa-times"></i></button>
                                    </form>
                                    <!--<a href="products.jsp.jsp?del=<?php echo $id; ?>"><i class="fa fa-times"></i></a>-->
                                </td>
                            </tr>
                            <%
                                        count++;
                                    }
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.4.1.min.js"
                integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
        crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>

        <script>
            $(document).ready(function () {
                console.log("loaded........")

                $('#delete-order-form').on('submit', function (event) {
                    event.preventDefault();

                    let form = new FormData(this);

                    $.ajax({
                        url: "../DeleteOrderServlet",
                        type: 'POST',
                        data: form,
                        success: function (data, textStatus, jqXHR) {
                            console.log(data)

                            if (data.trim() === 'done')
                            {

                                swal("Order is Deleted Successfully")
                                        .then((value) => {
                                            window.location = "orders.jsp"
                                        });
                            } else
                            {

                                swal(data);
                            }

                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            swal("something went wrong..try again");

                        },
                        processData: false,
                        contentType: false
                    });

                });
            });
        </script>

    </body>
</html>