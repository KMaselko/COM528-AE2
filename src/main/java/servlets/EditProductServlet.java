/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import dao.ProductDao;
import entities.Product;
import helper.ConnectionProvider;
import java.io.File;
import java.sql.*;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@MultipartConfig
@WebServlet(name = "EditProductServlet", urlPatterns = {"/EditProductServlet"})
public class EditProductServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            String id = request.getParameter("product_id");
            String code = request.getParameter("code");
            String name = request.getParameter("title");
            int categoryId = Integer.parseInt(request.getParameter("categories"));
            String description = request.getParameter("description");
            double price = Double.parseDouble(request.getParameter("price"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            Part part = request.getPart("image");
            String image = part.getSubmittedFileName();

            ProductDao productDao = new ProductDao(ConnectionProvider.getConnection());

            Product set = new Product();
            set = productDao.getProductObjectById(Integer.parseInt(id));

            Product product = new Product();
            product.setId(Integer.parseInt(id));
            product.setProductName(name);
            product.setProductUId(code);
            product.setQuantity(quantity);
            product.setCategoryId(categoryId);
            product.setDescription(description);
            product.setPrice(price);
            product.setProductImg(image);

            if (productDao.updateProduct(product)) {

                if (!set.getProductImg().equals(product.getProductImg())) {
                    String path = request.getRealPath("img") + File.separator + image;
                    FileOutputStream fos = new FileOutputStream(path);
                    InputStream is = part.getInputStream();
                    byte[] data = new byte[is.available()];
                    is.read(data);
                    fos.write(data);
                    fos.close();
                    is.close();
                }
                out.println("done");
            } else {
                out.println("Something went wrong!");
            }

        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
