package dao;

import entities.Product;
import java.sql.*;

public class ProductDao {

    private Connection con;

    public ProductDao(Connection con) {
        this.con = con;
    }

    public int getProcutsCount() {
        int count = 0;

        try {

            Statement statement = this.con.createStatement();
            String query = "SELECT COUNT(*) FROM products";
            ResultSet rs = statement.executeQuery(query);
            rs.next();
            count = rs.getInt(1);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return count;
    }

    public ResultSet getAllProducts() {
        ResultSet rs = null;

        try {

            String q = "SELECT * FROM products";
            PreparedStatement ps = this.con.prepareStatement(q);
            rs = ps.executeQuery();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return rs;
    }

    public boolean saveProduct(Product product) {
        boolean flag = false;

        try {

            String query = "INSERT INTO products (product_uid, product_name, category_id, description, price, quantity, product_img) VALUES (?,?,?,?,?,?,?)";
            PreparedStatement pstmt = this.con.prepareStatement(query);
            pstmt.setString(1, product.getProductUId());
            pstmt.setString(2, product.getProductName());
            pstmt.setInt(3, product.getCategoryId());
            pstmt.setString(4, product.getDescription());
            pstmt.setDouble(5, product.getPrice());
            pstmt.setInt(6, product.getQuantity());
            pstmt.setString(7, product.getProductImg());

            pstmt.executeUpdate();

            flag = true;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return flag;
    }

    public ResultSet getProductById(int id) {
        ResultSet rs = null;

        try {

            String query = "SELECT * FROM products WHERE id = ?";
            PreparedStatement pstmt = this.con.prepareStatement(query);
            pstmt.setInt(1, id);

            rs = pstmt.executeQuery();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return rs;
    }
    
    public Product getProductObjectById(int id) {
        Product product = new Product();

        try {

            String query = "SELECT * FROM products WHERE id = ?";
            PreparedStatement pstmt = this.con.prepareStatement(query);
            pstmt.setInt(1, id);

            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                product.setId(rs.getInt("id"));
                product.setProductUId(rs.getString("product_uid"));
                product.setProductName(rs.getString("product_name"));
                product.setCategoryId(rs.getInt("category_id"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getDouble("price"));
                product.setQuantity(rs.getInt("quantity"));
                product.setProductImg(rs.getString("product_img"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return product;
    }

    public ResultSet getProductLike(String title, int id) {
        ResultSet rs = null;

        try {

            String query = "SELECT * FROM products WHERE product_name LIKE? AND id != ?";
            PreparedStatement pstmt = this.con.prepareStatement(query);
            pstmt.setString(1, "%" + title + "%");
            pstmt.setInt(2, id);

            rs = pstmt.executeQuery();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return rs;
    }
    
    public boolean updateProduct(Product product) {
        boolean flag = false;
        
        try {

            String query = "UPDATE products SET product_uid=?, product_name=?, category_id=?, description=?, price=?, quantity=?, product_img=? WHERE id=?";
            PreparedStatement pstmt = this.con.prepareStatement(query);
            pstmt.setString(1, product.getProductUId());
            pstmt.setString(2, product.getProductName());
            pstmt.setInt(3, product.getCategoryId());
            pstmt.setString(4, product.getDescription());
            pstmt.setDouble(5, product.getPrice());
            pstmt.setInt(6, product.getQuantity());
            pstmt.setString(7, product.getProductImg());
            pstmt.setInt(8, product.getId());

            pstmt.executeUpdate();

            flag = true;

        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return flag;
    }
    
    public boolean deleteProductById(int id) {
        boolean flag = false;

        try {

            String query = "DELETE FROM products WHERE id = ?";
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
