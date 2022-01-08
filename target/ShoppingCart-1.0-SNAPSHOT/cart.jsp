<%@page import="entities.User"%>
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
            <div class="row">
                <div class="col-8">
                    <div class="card-body">

                    </div>
                    <div id="order-message-success" class="alert alert-success" role="alert">
                        Order is Successfully Submitted
                    </div>
                    <div id="order-message-danger" class="alert alert-danger" role="alert">
                        Something went wrong!!!
                    </div>
                </div>
                <%
                    User user = (User) session.getAttribute("user");
                    if (user != null) {
                %>
                <div class="col-4">
                    <h5>Your Details for this order</h5>
                    <table class="table">
                        <tbody>
                            <tr>
                                <td>Name</td>
                                <td><%= user.getName()%></td>
                            </tr>
                            <tr>
                                <td>Email</td>
                                <td><%= user.getEmail()%></td>
                            </tr>
                            <tr>
                                <td>Phone</td>
                                <td><%= user.getPhone()%></td>
                            </tr>
                            <tr>
                                <td>Address</td>
                                <td><%= user.getAddress()%></td>
                            </tr>
                            <tr>
                        <form id="checkout-form" method="post" action="CartServlet">
                            <td colspan="2">
                                <input type="text" name="userid" value="<%= user.getId()%>" hidden />
                                <input type="submit" name="submit" class="form-control btn btn-outline-primary" value="Check Out" />
                            </td>
                        </form>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <%
                } else {
                %>
                <div class="col-4">
                    <h5>Login First to check out</h5>
                    <a href="login.jsp" class="btn btn-outline-primary form-control">Login</a>
                </div>
                <%
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

        <script>
            $(document).ready(function () {
                console.log("inside cart page.");

                $('#checkout-form').on('submit', function (event) {
                    event.preventDefault();

                    let form = new FormData(this);
                    let id = form.get('userid');

                    let cartString = localStorage.getItem("cart");
                    let cart = JSON.parse(cartString);

                    cart.forEach((a) => {
                        a.userId = id
                    });

                    cartString = JSON.stringify(cart);

                    console.log(cartString);

                    //send register servlet:
                    $.ajax({
                        url: "CartServlet",
                        type: 'POST',
                        data: {data: cartString},
                        success: function (data, textStatus, jqXHR) {
                            console.log(data)
                            if (data.trim() === 'done')
                            {
                                localStorage.clear();
                                swal("Successfully Ordered")
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