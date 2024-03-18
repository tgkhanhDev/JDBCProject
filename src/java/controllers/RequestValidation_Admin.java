/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import DAO.AccountDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author ACER
 */
public class RequestValidation_Admin extends HttpServlet {

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
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet RequestValidation_Admin</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RequestValidation_Admin at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");

            String accPhone = request.getParameter("AccountPhone");
            String managerID = request.getParameter("ManagerID");

            String serID = request.getParameter("SerID");
            String reqTypeID = request.getParameter("reqTypeID");
            String Description = request.getParameter("Description");

            int checkPhone = new AccountDAO().checkPhone(accPhone);

            out.println("<h3>accPhone: " + accPhone + "</h3>");
            out.println("<h3>managerID: " + managerID + "</h3>");
            out.println("<h3>serID: " + serID + "</h3>");
            out.println("<h3>reqTypeID: " + reqTypeID + "</h3>");
            out.println("<h3>Description: " + Description + "</h3>");

            if (checkPhone == 0)
            {
                request.setAttribute("validateMessage", "Số điện thoại không tồn tại, vui lòng thử lại");
                request.getRequestDispatcher("mainController?action=" + CONSTANTS.VIEWPRODUCT_ADMIN).forward(request, response);
            } else if (managerID.trim().equals("") || managerID == null)
            {
                request.setAttribute("validateMessage", "Hết phiên đăng nhập, vui lòng thử lại");
                request.getRequestDispatcher("mainController?action=" + CONSTANTS.VIEWPRODUCT_ADMIN).forward(request, response);
            } else
            {
                request.getRequestDispatcher("mainController?action=" + CONSTANTS.ADDINFO_ADMIN).forward(request, response);
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
