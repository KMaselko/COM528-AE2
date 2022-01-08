package servlets;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import dao.OrderDao;
import entities.Order;
import entities.ShoppingCart;
import helper.ConnectionProvider;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@MultipartConfig
@WebServlet(name = "CartServlet", urlPatterns = {"/CartServlet"})
public class CartServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            String data = request.getParameter("data");
            data = data.substring(1, data.length() - 1);
            
            ObjectMapper mapper = new ObjectMapper();
            
            String[] str = data.split("},");
            for (int i = 0; i < str.length - 1; i++) {
                str[i] += "}";
            }
            List<ShoppingCart> carts = new ArrayList<>();
            for (int i = 0; i < str.length; i++) {
                ShoppingCart cart = mapper.readValue(str[i], ShoppingCart.class);
                carts.add(cart);
            }
            boolean istrue = false;
            for (ShoppingCart cart : carts) {
                int uid = cart.getUserId();
                int pid = cart.getProductId();
                int quantity = cart.getProductQuantity();
                
                // JDBC
                OrderDao orderDao = new OrderDao(ConnectionProvider.getConnection());
                Order order = new Order(uid, pid, quantity, "paid");
                if (orderDao.saveOrder(order)) {
                    istrue = true;
                } else {
                    istrue = false;
                }
            }
            
            if (istrue) {
                out.println("done");
            } else {
                out.println("Something went wrong");
            }

//            ShoppingCart cart = mapper.readValue(str[0] + "}", ShoppingCart.class);
//            System.out.println(cart.getProductName());
//            List<ShoppingCart> carts = mapper.readValue(data, new TypeReference<List<ShoppingCart>>(){});
//            System.out.println(carts.size());
//            for (ShoppingCart cart : carts) {
//                System.out.println(cart.getProductName());
//            }
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
