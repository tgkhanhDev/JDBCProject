/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import DAO.ProductDAO;
import DAO.RequestDAO;
import DAO.StatusTypeDAO;
import DTO.Account;
import DTO.Request;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author ACER
 */
public class TechnicianController_Technician extends HttpServlet {

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
            ArrayList list = new ArrayList();
            int size = 0;

            HttpSession session = request.getSession();

            String sec = request.getParameter("sec");
            String search = request.getParameter("search");

            String currPage = request.getParameter("page");
            if (currPage == null)
            {
                currPage = "1";
            }

            if (sec == null)
            {
                sec = "1";
            }

            switch (sec)
            {
                case "1":
                    Account acc = (Account) session.getAttribute("loginUser");
                    
                    session.setAttribute("statusList", new StatusTypeDAO().getAllStatusType());
                    
                    String date1 = request.getParameter("date");
                    String status1 = request.getParameter("status");
                    date1 = (date1 == null || date1.trim().equals("null")) ? date1 = "1" : date1;
                    status1 = (status1 == null || status1.trim().equals("null")) ? "" : status1;
                    search = (search == null || search.trim().equals("null")) ? "" : search;

                    list = new RequestDAO().getSortRequestByManagerID(date1, search, status1, acc.getAccountID());
                    break;
            }

            request.setAttribute("sec", sec);
            session.setAttribute("list", list);
            size = list.size();
            session.setAttribute("size", size);
            
            request.getRequestDispatcher("mainController?action=" + CONSTANTS.VIEW_TECHNICIAN).forward(request, response);

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
