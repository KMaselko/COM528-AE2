package dao;

import entities.User;
import java.sql.*;

public class UserDao {
    
    private Connection con;
    
    public UserDao(Connection con) {
        this.con = con;
    }
    
    public boolean loginWithEmailAndPassword(String email, String Password) {
        boolean flag = false;
        
        try {
            
            String query = "SELECT * FROM users WHERE email = ? AND password = ?";
            PreparedStatement p = this.con.prepareStatement(query);
            p.setString(1, email);
            p.setString(2, Password);
            
            ResultSet set = p.executeQuery();
            
            if (set.next())
                flag = true;
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return flag;
    }
    
    public User getUserWithEmail(String email) {
        User user = new User();
        
        try {
            
            String query = "SELECT * FROM users WHERE email = ?";
            PreparedStatement p = this.con.prepareStatement(query);
            p.setString(1, email);
            
            ResultSet set = p.executeQuery();
            
            if (set.next()) {
                
                user.setId(set.getInt("id"));
                user.setName(set.getString("name"));
                user.setPhone(set.getString("phone"));
                user.setEmail(set.getString("email"));
                user.setAddress(set.getString("address"));
                user.setPassword(set.getString("password"));
                user.setRole(set.getString("role"));
                
            }
            
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }
    
    public ResultSet getUserById(int id) {
        ResultSet set = null;
        
        try {
            
            String query = "SELECT * FROM users WHERE id = ?";
            PreparedStatement p = this.con.prepareStatement(query);
            p.setInt(1, id);
            
            set = p.executeQuery();
            
            
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return set;
    }
    
    public boolean saveUser(User user) {
        boolean flag = false;
        
        try {
            
            String query = "INSERT INTO users (name, email, phone, password, address, role) VALUES (?,?,?,?,?,?)";
            PreparedStatement pstmt = this.con.prepareStatement(query);
            pstmt.setString(1, user.getName());
            pstmt.setString(2, user.getEmail());
            pstmt.setString(3, user.getPhone());
            pstmt.setString(4, user.getPassword());
            pstmt.setString(5, user.getAddress());
            pstmt.setString(6, user.getRole());

            pstmt.executeUpdate();

            flag = true;
            
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return flag;
    }
    
    public boolean updateUser(User user) {
        boolean flag = false;
        
        try {
            
            String query = "UPDATE users SET name = ?, email=?, phone=?, password=?, address=? WHERE id=?";
            PreparedStatement pstmt = this.con.prepareStatement(query);
            pstmt.setString(1, user.getName());
            pstmt.setString(2, user.getEmail());
            pstmt.setString(3, user.getPhone());
            pstmt.setString(4, user.getPassword());
            pstmt.setString(5, user.getAddress());
            pstmt.setInt(6, user.getId());

            pstmt.executeUpdate();

            flag = true;
            
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return flag;
    }
    
}
