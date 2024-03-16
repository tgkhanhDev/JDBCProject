/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import DAO.ProductDAO;
import DTO.Product;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author ACER
 */
public class handleTableCart extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter())
        {
            /* TODO output your page here. You may use following sample code. */

            out.println("<h1>Servlet handleTableCart at " + request.getContextPath() + "</h1>");

            HttpSession session = request.getSession();
            HashMap<String, Integer> cart = (HashMap<String, Integer>) session.getAttribute("cartList");
            
            String prdID = request.getParameter("prdID");

            if (cart == null)
            {
                cart = new HashMap();
            }

            //check exist:
            if (cart.containsKey(prdID))
            {
                int quantity = cart.get(prdID);
                quantity++;
                cart.put(prdID, quantity);
            } else
            {
                cart.put(prdID, 1);
            }

            //set cart to session
            session.setAttribute("cartList", cart);

            //Count total Item
            int total = 0;
            for (Map.Entry<String, Integer> entry : cart.entrySet())
            {
                total += entry.getValue();
                out.print("<h1>"+entry.getKey()+"----"+entry.getValue()+"</h1>");
            }
            
            session.setAttribute("totalCartItems", total);
            
            response.sendRedirect("mainController?action="+CONSTANTS.GETPRODUCTS);

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
