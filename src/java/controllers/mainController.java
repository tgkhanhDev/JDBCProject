/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import DTO.Product;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author ACER
 */
public class mainController extends HttpServlet {

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
            String url = "";
            
            String action = request.getParameter("action");
            
            if (action == null)
            {
                action = CONSTANTS.GETHOME;
            }

            switch (action)
            {
                case CONSTANTS.VIEWHOME:
                    url = "page/index.jsp";
                    break;
                case CONSTANTS.GETHOME:
                    url = "homeController";
                    break;
                case CONSTANTS.GETPRODUCTS:
                    url = "productController";
                    break;
                case CONSTANTS.VIEWPRODUCTS:
                    url = "page/productPage/products.jsp";
                    break;
                case CONSTANTS.GETLOGINPAGE:
                    url = "loginController";
                    break;
                case CONSTANTS.VIEWLOGINPAGE:
                    url = "page/loginPage/login.jsp";
                    break;
                    
//                    CALL GET => VIEW 
//                    CALL FORM => GET => View 
                case CONSTANTS.GETPRODUCT_ADMIN:
                    url = "AdminController_Admin"; 
                    break;
                case CONSTANTS.VIEWPRODUCT_ADMIN:
                    url = "page/adminPage/admin.jsp";
                    break;
                    //Lấy thông tin  ra formInput
                case CONSTANTS.GETFORMINFOPRODUCT_ADMIN:
                    url="ProductsFormController_Admin";
                    break;
                case CONSTANTS.UPDATEINFO_ADMIN:
                    url="UpdateController_Admin";
                    break;
                case CONSTANTS.ADDINFO_ADMIN:
                    url="AddController_Admin";
                    break;
                case CONSTANTS.BLOCK_ADMIN:
                    url="BlockController_Admin";
                    break;
                default:
                    break;
            }

//            url="productController";
//            out.print("action: "+ action);
            request.getRequestDispatcher(url).forward(request, response);

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
