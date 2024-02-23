/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import DAO.AccountDAO;
import DTO.Account;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Lenovo
 */
public class LoginController extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            //            lấy dữ liệu  từ  login.jsp
            String phone = request.getParameter("txtphone");
            String gmail = request.getParameter("txtgmail");
            String pass = request.getParameter("txtpass");

            
//         sử dụng hàm để tìm Account
            AccountDAO d = new AccountDAO();
            Account acc = d.getClientAccount(phone, gmail, pass);
            if (acc != null) {
                // luu trong trong session
                HttpSession session = request.getSession();
                session.setAttribute("loginUser", acc);
                int status = Integer.parseInt(acc.getStatus());
                if(status == 1){
              request.getRequestDispatcher("mainController?action=homepagelogin").forward(request, response);
                }else{
                  request.setAttribute("ERROR", " Tài khoản của bạn đã vi phạm ");
                request.getRequestDispatcher("mainController?action=loginpage&renotify=0&sec=1").forward(request, response);
                }
            } else {
//                    them cai thong bao sai
                request.setAttribute("ERROR", " Gmail hoặc mật khẩu đã sai ");
                request.getRequestDispatcher("mainController?action=loginpage&renotify=0&sec=1").forward(request, response);
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
