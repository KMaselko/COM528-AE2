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

        <title>Products Page</title>
    </head>
    <body>
        <jsp:include page="navbar.jsp" />
        <br>

        <div class="container-fluid">

            <div class="row">
                <jsp:include page="sidebar.jsp" />

                <div class="col-9">
                    <h1><i class="fa fa-plus-square"></i> All Products</h1>
                    <div class="breadcrumb">
                        <li><a href="index.jsp"><i class="fa fa-tachometer"></i> Dashboard</a></li>
                        <li class="active pl-2"><i class="fa fa-plus-square"></i> All Products</li>
                    </div>
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th scope="col">#</th>
                                <th scope="col">Product Name</th>
                                <th scope="col">Product Code</th>
                                <th scope="col">Price</th>
                                <th scope="col">Quantity</th>
                                <th scope="col">Edit</th>
                                <th scope="col">Delete</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Get All Products form Database -->
                            <%
                                ProductDao productDao = new ProductDao(ConnectionProvider.getConnection());
                                ResultSet rs = productDao.getAllProducts();
                                int count = 1;
                                if (rs != null) {
                                    while (rs.next()) {
                            %>
                            <tr>
                                <th scope="row"><%= count%></th>
                                <td><%= rs.getString("product_name")%></td>
                                <td><%= rs.getString("product_uid")%></td>
                                <td><%= rs.getDouble("price")%></td>
                                <td><%= rs.getInt("quantity")%></td>
                                <td><a href="edit-product.jsp?edit=<%= rs.getInt("id")%>"><i class="fa fa-pencil"></i></a></td>
                                <td>
                                    <form id="delete-product-form" action="DeleteProductServlet" method="post">
                                        <input type="text" name="product_id" value="<%= rs.getInt("id")%>" hidden />
                                        <button type="submit" class="btn-outline-primary"><i class="fa fa-times"></i></button>
                                    </form>
                                    <!--<a href="products.jsp.jsp?del="><i class="fa fa-times"></i></a>-->
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
                console.log("inside producs page")

                $('#delete-product-form').on('submit', function (event) {
                    event.preventDefault();

                    let form = new FormData(this);

                    $.ajax({
                        url: "../DeleteProductServlet",
                        type: 'POST',
                        data: form,
                        success: function (data, textStatus, jqXHR) {
                            console.log(data);

                            if (data.trim() === 'done')
                            {

                                swal("Product is Deleted Successfully")
                                        .then((value) => {
                                            window.location = "products.jsp"
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