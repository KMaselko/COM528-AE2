package dao;

import entities.Category;
import java.sql.*;

public class CategoryDao {
    
    private Connection con;
    
    public CategoryDao(Connection con) {
        this.con = con;
    }
    
    public int getCategoriesCount() {
        int count = 0;
        
        try {
            
            Statement statement = con.createStatement();
            String query = "SELECT COUNT(*) FROM categories";
            ResultSet rs = statement.executeQuery(query);
            rs.next();
            count = rs.getInt(1);
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return count;
    }
    
    public ResultSet getAllCategories() {
        ResultSet rs = null;
        try {
            
            String q = "SELECT * FROM categories";
            PreparedStatement ps = this.con.prepareStatement(q);
            rs = ps.executeQuery();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return rs;
    }
    
    public boolean saveCategory(Category category) {
        boolean flag = false;
        
        try {
            
            String query = "INSERT INTO categories (category_name) VALUES (?)";
            PreparedStatement pstmt = this.con.prepareStatement(query);
            pstmt.setString(1, category.getCategoryName());
            
            pstmt.executeUpdate();
            
            flag = true;
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return flag;
    }
    
    public boolean updateCategory(Category category) {
        boolean flag = false;
        
        try {
            
            String query = "UPDATE categories set category_name = ? WHERE id = ?";
            PreparedStatement pstmt = this.con.prepareStatement(query);
            pstmt.setString(1, category.getCategoryName());
            pstmt.setInt(2, category.getId());
            
            pstmt.executeUpdate();
            
            flag = true;
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return flag;
    }
    
    public boolean deleteCategoryById(int id) {
        boolean flag = false;
        
        try {
            
            String query = "DELETE FROM categories WHERE id = ?";
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
