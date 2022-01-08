<%@page import="entities.User"%>
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
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
        <script src="js/script.js"></script>

        <title>Category Page</title>
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
                    <%
                        String del = request.getParameter("del");
                        if (del != null) {

                            CategoryDao categoryDao = new CategoryDao(ConnectionProvider.getConnection());

                            if (categoryDao.deleteCategoryById(Integer.parseInt(del))) {
                    %>
                    <div class="alert alert-success" role="alert">
                        Category Deleted Successfully
                    </div>
                    <%
                            }
                        }
                    %>
                    <h1><i class="fa fa-folder-open"></i> Categories <small>Statistics Overview</small></h1>
                    <div class="breadcrumb">
                        <li class=""><a href="index.php"><i class="fa fa-tachometer"></i> Dashboard </a></li>
                        <li class="active pl-2"><i class="fa fa-folder-open"></i> Categories</li>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <form id="categories-form" action="AddCategoryServlet" method="POST">
                                <div class="form-group">
                                    <label for="category">Category Name:</label>
                                    <input type="text" name="cat-name" placeholder="Category Name" class="form-control">
                                </div>
                                <input type="submit" name="submit" value="Add Category" class="btn btn-primary">
                            </form>
                            <hr>
                            <%
                                String id = request.getParameter("edit");
                                String name = request.getParameter("name");
                                if (id != null) {
                            %>
                            <form id="update-category-from" action="UpdateCategoryServlet" method="POST">
                                <div class="form-group">
                                    <label for="category">Update Category:</label>
                                    <input type="text" name="cat-name" value="<%= name%>" placeholder="Category Name" class="form-control">
                                    <input type="text" name="cat-id" value="<%= id%>" class="form-control" hidden>
                                </div>
                                <input type="submit" name="update" value="Update Category" class="btn btn-primary">
                            </form>
                            <%
                                }
                            %>
                        </div>
                        <div class="col-md-6">
                            <table id="category-table" class="table table-hover table-bordered">
                                <thead>
                                    <tr>
                                        <th>Sr #</th>
                                        <th>Category Name</th>
                                        <th>Edit</th>
                                        <th>Del</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <!-- Get All Categories from DB -->
                                    <%
                                        CategoryDao categoryDao = new CategoryDao(ConnectionProvider.getConnection());
                                        ResultSet rs = categoryDao.getAllCategories();
                                        int count = 1;
                                        if (rs != null) {
                                            while (rs.next()) {
                                    %>
                                    <tr>
                                        <td><%= count%></td>
                                        <td><%= rs.getString("category_name")%></td>
                                        <td><a href="categories.jsp?edit=<%= rs.getInt("id")%>&name=<%= rs.getString("category_name")%>"><i class="fa fa-pencil"></i></a></td>
                                        <td>
                                            <a href="categories.jsp?del=<%= rs.getInt("id")%>"><i class="fa fa-times"></i></a>
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

                $('#categories-form').on('submit', function (event) {
                    event.preventDefault();

                    let form = new FormData(this);

                    //send register servlet:
                    $.ajax({
                        url: "../AddCategoryServlet",
                        type: 'POST',
                        data: form,
                        success: function (data, textStatus, jqXHR) {
                            console.log(data)

                            if (data.trim() === 'done')
                            {

                                swal("Category Added Successfully")
                                        .then((value) => {
                                            window.location = "categories.jsp"
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


                $('#update-category-from').on('submit', function (event) {
                    event.preventDefault();

                    let form = new FormData(this);

                    //send register servlet:
                    $.ajax({
                        url: "../UpdateCategoryServlet",
                        type: 'POST',
                        data: form,
                        success: function (data, textStatus, jqXHR) {
                            console.log(data)

                            if (data.trim() === 'done')
                            {

                                swal("Category Updated Successfully")
                                        .then((value) => {
                                            window.location = "categories.jsp"
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