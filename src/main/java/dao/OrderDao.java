package dao;

import entities.Order;
import java.sql.*;

public class OrderDao {

    private Connection con;

    public OrderDao(Connection con) {
        this.con = con;
    }

    public int getOrdersCount() {
        int count = 0;

        try {

            Statement statement = con.createStatement();
            String query = "SELECT COUNT(*) FROM orders";
            ResultSet rs = statement.executeQuery(query);
            rs.next();
            count = rs.getInt(1);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return count;
    }

    public ResultSet getAllOrders() {
        ResultSet rs = null;

        try {

            String q = "SELECT * FROM orders WHERE payment = ?";
            PreparedStatement ps = this.con.prepareStatement(q);
            ps.setString(1, "paid");
            rs = ps.executeQuery();

//            if (rs.next())
//            System.out.println(rs.getString("quantity"));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rs;
    }

    public boolean saveOrder(Order order) {
        boolean flag = false;

        try {

            String query = "INSERT INTO orders (user_id, product_id, quantity, payment) VALUES(?,?,?,?)";
            PreparedStatement ps = this.con.prepareStatement(query);
            ps.setInt(1, order.getUserId());
            ps.setInt(2, order.getProductId());
            ps.setInt(3, order.getQuantity());
            ps.setString(4, order.getPayment());

            ps.executeUpdate();

            flag = true;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return flag;
    }

    public ResultSet getOrderByUserIdAndProductId(int userid, int productid) {
        ResultSet set = null;
        try {

            String query = "SELECT products.product_uid, products.product_name, products.category_id, products.description, products.price, products.product_img, users.name, users.email, users.phone, users.address FROM users, products WHERE users.id = ? AND products.id = ?";

            PreparedStatement ps = this.con.prepareStatement(query);
            ps.setInt(1, userid);
            ps.setInt(2, productid);

            set = ps.executeQuery();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return set;
    }

    public boolean deleteOrderById(int id) {
        boolean flag = false;

        try {

            String query = "DELETE FROM orders WHERE id = ?";
            PreparedStatement ps = this.con.prepareStatement(query);
            ps.setInt(1, id);

            ps.executeUpdate();

            flag = true;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return flag;
    }

    public ResultSet getOrderById(int id) {
        ResultSet set = null;
        try {

            String query = "SELECT * FROM orders WHERE id = ?";

            PreparedStatement ps = this.con.prepareStatement(query);
            ps.setInt(1, id);

            set = ps.executeQuery();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return set;
    }
    
    public boolean deleteOrderByProductId(int id) {
        boolean flag = false;

        try {

            String query = "DELETE FROM orders WHERE product_id = ?";
            PreparedStatement ps = this.con.prepareStatement(query);
            ps.setInt(1, id);

            ps.executeUpdate();

            flag = true;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return flag;
    }
}
