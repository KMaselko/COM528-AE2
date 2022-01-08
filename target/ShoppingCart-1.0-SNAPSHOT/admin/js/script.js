function deleteCategory(id) {

    $.ajax({
        url: "../DeleteCategoryServlet",
        type: 'POST',
        data: {category_id: id},
        success: function (data, textStatus, jqXHR) {
            console.log(data)

            if (data.trim() === 'done')
            {

                swal("Category Deleted Successfully")
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



}


$(document).ready(function () {
    console.log("script from admin panel")
});