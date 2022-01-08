function add_to_cart(pid, pname, price)
{
    let cart = localStorage.getItem("cart");


    if (cart == null) {

        let products = [];
        let product = {productId: pid, productName: pname, productQuantity: 1, productPrice: price};
        products.push(product);
        localStorage.setItem("cart", JSON.stringify(products));
        console.log("Product is added for the first time");

    } else {

        let pcart = JSON.parse(cart);

        let oldProduct = pcart.find((item) => item.productId == pid)

        if (oldProduct) {

            // we have to increase the quantity
            oldProduct.productQuantity = oldProduct.productQuantity + 1;
            pcart.map((item) => {
                if (item.productId == oldProduct.productId) {
                    item.productQuantity = oldProduct.productQuantity;
                }
            })
            localStorage.setItem("cart", JSON.stringify(pcart));
            console.log("Product quantity is increased");

        } else {

            // we have to add the product
            let product = {productId: pid, productName: pname, productQuantity: 1, productPrice: price};
            pcart.push(product);
            localStorage.setItem("cart", JSON.stringify(pcart));
            console.log("Product is added");

        }
    }
    update_cart();
}


// update cart
function update_cart()
{
    let cartString = localStorage.getItem("cart");
    let cart = JSON.parse(cartString);

    if (cart == null || cart.length == 0) {
        console.log("Cart is empty");
        $(".cart-items").html();
    } else {
        // there is something in cart to show
        $(".cart-items").html(cart.length);

        // add to table
        let table = `
        <table class='table'>
        <thead class='thead-light'>
        <tr>
        <th>Item Name</th>
        <th>Price</th>
        <th>Quantity</th>
        <th>Total</th>
        <th>Action</th>
        </tr>
        </thead>`;

        let totalPrice = 0;
        cart.map((item) => {
            table += `
            <tr>
            <td> ${item.productName} </td>
            <td> ${item.productPrice} </td>
            <td> ${item.productQuantity} </td>
            <td> ${item.productQuantity * item.productPrice} </td>
            <td><button onclick='deleteItemFromCart(${item.productId})' class='btn btn-danger btn-sm'>Remove</button></td>
            </tr>`;
            totalPrice += item.productPrice * item.productQuantity;
        });

        table = table + `
        <tr>
        <td colspan='5' class='text-right font-weight-bold'>Total Price: ${totalPrice}</td>
        </tr>
        </table>`;
        $(".card-body").html(table);
    }
}

// we are going to delete item from cart
function deleteItemFromCart(pid)
{
    let cart = JSON.parse(localStorage.getItem("cart"));

    let newCart = cart.filter((item) => item.productId != pid)

    localStorage.setItem("cart", JSON.stringify(newCart));

    update_cart();

}

function checkout(id) {

    let cartString = localStorage.getItem("cart");
    let cart = JSON.parse(cartString);

    cart.forEach((a) => {
        a.userId = id
    });

    cartString = JSON.stringify(cart);

    console.log("Inside CheckOut");
    console.log(cartString);

    $.ajax({
        url: "CartServlet",
        type: 'POST',
        data: {data: cartString},
        success: function (data, textStatus, jqXHR) {
            console.log(data);

            if (data.trim() === 'done')
            {
                console.log(data);
                swal(data);
                
            } else
            {
                console.log(data);
                swal(data);
            }

        },
        error: function (jqXHR, textStatus, errorThrown) {
            swal("something went wrong..try again");

        },
        processData: false,
        contentType: false
    });
}

$(document).ready(function () {
    update_cart();
    $("#order-message-success").hide();
    $("#order-message-danger").hide();
});