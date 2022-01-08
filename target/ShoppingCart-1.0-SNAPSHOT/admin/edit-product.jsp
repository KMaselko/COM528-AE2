<%@page import="entities.User"%>
<%@page import="entities.Product"%>
<%@page import="dao.ProductDao"%>
<%@page import="helper.ConnectionProvider"%>
<%@page import="dao.CategoryDao"%>
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

        <title>Add New Product</title>
    </head>
    <body>
        <%
            User user = (User) session.getAttribute("user");
            if (user == null || user.getRole().equals("normal")) {
                response.sendRedirect("../login.jsp");
            }
        %>
        <jsp:include page="navbar.jsp" />

        <br>
        <div class="container-fluid">
            <div class="row">
                <jsp:include page="sidebar.jsp" />
                <div class="col-9">
                    <h1><i class="fa fa-plus-square"></i> Add Product <small>Add New Product</small></h1>
                    <div class="breadcrumb">
                        <li><a href="index.php"><i class="fa fa-tachometer"></i> Dashboard</a></li>
                        <li class="active pl-2"><i class="fa fa-plus-square"></i> Add New Product</li>
                    </div>
                    <!-- JDBC -->
                    <%
                        String id = request.getParameter("edit");
                        ProductDao productDao = new ProductDao(ConnectionProvider.getConnection());
                        ResultSet product = productDao.getProductById(Integer.parseInt(id));
                        if (product.next())
                    %>
                    <div class="row">
                        <div class="col-12">
                            <form id="edit-product-form" action="../EditProductServlet" method="POST" enctype="multipart/form-data">
                                <div class="form-group">
                                    <label for="title">Title*</label>
                                    <input type="text" name="product_id" value="<%= product.getInt("id") %>" hidden>
                                    <input type="text" name="title" value="<%= product.getString("product_name") %>" placeholder="Product Title" class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label for="title">Description*</label>
                                    <textarea name="description" id="textarea" rows="10" class="form-control" placeholder="Product Description" required><%= product.getString("description")%></textarea>
                                </div>
                                <div class="row">
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label for="file">Post Image:*</label>
                                            <input type="file" name="image" value="<%= product.getString("product_img") %>">
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label for="categories">Categories:*</label>
                                            <select name="categories" id="categories" class="form-control">
                                                <!-- Get All Categories from DB -->
                                                <%
                                                    CategoryDao categoryDao = new CategoryDao(ConnectionProvider.getConnection());
                                                    ResultSet rs = categoryDao.getAllCategories();
                                                    int count = 1;
                                                    if (rs != null) {
                                                        while (rs.next()) {
                                                %>
                                                <option value="<%= rs.getInt("id")%>"><%= rs.getString("category_name")%></option>
                                                <%
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label for="tags">Price* £:</label>
                                            <input type="number" name="price" value="<%= product.getString("price") %>" placeholder="Price" class="form-control">
                                        </div>
                                        <div class="form-group">
                                            <label for="tags">Quantity:*</label>
                                            <input type="number" name="quantity" value="<%= product.getString("quantity") %>" placeholder="Quantity" class="form-control">
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label for="tags">Product Code*:</label>
                                            <input type="text" name="code" value="<%= product.getString("product_uid") %>" placeholder="Product Code #123 e.g" class="form-control" required>
                                        </div>
                                    </div>
                                </div>
                                <input type="submit" name="submit" class="btn btn-primary" value="Update Order">
                                <div class="mb-5"></div>
                            </form>
                        </div>
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

                    $('#edit-product-form').on('submit', function (event) {
                        event.preventDefault();

                        let form = new FormData(this);

                        //send register servlet:
                        $.ajax({
                            url: "../EditProductServlet",
                            type: 'POST',
                            contentType: "multipart/form-data",
                            data: form,
                            success: function (data, textStatus, jqXHR) {
                                console.log(data);
                                if (data.trim() === 'done')
                                {

                                    swal("Product Updated Successfully")
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