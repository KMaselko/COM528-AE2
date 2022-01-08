<%@page import="entities.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="./css/style.css"/>
        <link rel="stylesheet"
              href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
        <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <title>Edit Profile Page</title>
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
                    <form id="edit-product-" action="EditProfileServlet" method="post">
                        <div class="form-group">
                            <label>Full Name</label>
                            <input type="text" name="userid" value="<%= user.getId()%>"  hidden/>
                            <input type="text" name="name" value="<%= user.getName()%>" class="form-control" placeholder="Full Name"/>
                        </div>
                        <div class="form-group">
                            <label>Email</label>
                            <input type="email" name="email" value="<%= user.getEmail()%>" class="form-control" placeholder="Email" required />
                        </div>
                        <div class="form-group">
                            <label>Password</label>
                            <input type="password" name="password" value="<%= user.getPassword()%>" class="form-control" placeholder="Password" required />
                        </div>
                        <div class="form-group">
                            <label>Address</label>
                            <input type="text" name="address" value="<%= user.getAddress()%>" class="form-control" placeholder="Address" required />
                        </div>
                        <div class="form-group">
                            <label>Mobile</label>
                            <input type="text" name="phone" value="<%= user.getPhone()%>" class="form-control" placeholder="Mobile Number" required />
                        </div>
                        <div class="form-group">
                            <input type="submit" name="submit" class="btn btn-outline-primary" value="Update Profile" />
                        </div>
                    </form>
                </div>
            </div>
            <%
                }
            %>
        </div>
        <script src="https://code.jquery.com/jquery-3.4.1.min.js"
                integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
        crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>

        <script>
            $(document).ready(function () {
                console.log("inside edit profile page.");

                $('#edit-product-form').on('submit', function (event) {
                    event.preventDefault();

                    let form = new FormData(this);

                    $.ajax({
                        url: "EditProfileServlet",
                        type: 'POST',
                        data: form,
                        success: function (data, textStatus, jqXHR) {
                            console.log(data)
                            if (data.trim() === 'done')
                            {
                                localStorage.clear();
                                swal("Profile Successfully Updated")
                                        .then((value) => {
                                            window.location = "index.jsp"
                                        });
                            } else
                            {
                                swal(data);
                            }

                        }
                    });
                });
            });
        </script>
    </body>
</html>