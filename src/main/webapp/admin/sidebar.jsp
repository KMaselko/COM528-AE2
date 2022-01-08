<%@page import="dao.OrderDao"%>
<%@page import="dao.CategoryDao"%>
<%@page import="helper.ConnectionProvider"%>
<%@page import="dao.ProductDao"%>
<%
    ProductDao productDao = new ProductDao(ConnectionProvider.getConnection());
    int totalProducts = productDao.getProcutsCount();
    
    CategoryDao categoryDao = new CategoryDao(ConnectionProvider.getConnection());
    int totalCategories = categoryDao.getCategoriesCount();
    
    OrderDao orderDao = new OrderDao(ConnectionProvider.getConnection());
    int totalOrders = orderDao.getOrdersCount();
%>

<div class="col-3">
    <div class="list-group">
        <a href="index.jsp" class="list-group-item list-group-item-action active">
            <i class="fa fa-tachometer"></i> Dashboard
        </a>
        <a href="products.jsp" class="list-group-item list-group-item-action">
            <i class="fa fa-file"></i> All Products
            <span class="badge badge-primary badge-pill"><%= totalProducts %></span>
        </a>
        <a href="add-product.jsp" class="list-group-item list-group-item-action">
            <i class="fa fa-database"></i> Add New Product
            <!--<span class="badge badge-primary badge-pill">14</span>-->
        </a>
        <a href="categories.jsp" class="list-group-item list-group-item-action">
            <i class="fa fa-folder-open"></i> Categories
            <span class="badge badge-primary badge-pill"> <%= totalCategories %> </span>
        </a>
        <a href="orders.jsp" class="list-group-item list-group-item-action">
            <i class="fa fa-user"></i> Orders
            <span class="badge badge-primary badge-pill"> <%= totalOrders %> </span>
        </a>
    </div>
</div>