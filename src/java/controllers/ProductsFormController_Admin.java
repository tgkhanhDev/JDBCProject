/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import DAO.AccountDAO;
import DAO.EmployeeDAO;
import DAO.ProductDAO;
import DAO.RequestDAO;
import DAO.ServiceDAO;
import DAO.TransactionDAO;
import DTO.Account;
import DTO.Employee;
import DTO.Product;
import DTO.Request;
import DTO.Transaction;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author ACER
 */
public class ProductsFormController_Admin extends HttpServlet {

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
            //INFO NEEDED: sec , itemID
            //Result => form info
            /* Xu Ly Form  */
            Object formList = new Object();
            String itemID = request.getParameter("itemID");
            String sec = (String) request.getParameter("sec");
            String flag = (String) request.getParameter("reload");

            switch (sec)
            {
                case "1":
                    formList = new ProductDAO().getProductByID(itemID);
                    break;
                case "2":
                    formList = (Account) new AccountDAO().getAccountByID(itemID);
                    break;
                case "3":
                    break;
                case "4":
                    String managerID4 = request.getParameter("newManagerID");
                    Employee managerAcc = new EmployeeDAO().getEmployeeByID(Integer.parseInt(managerID4));
                    request.setAttribute("formAccount", managerAcc);

                    String reqID = request.getParameter("reqID");
                    Request reqForm = new RequestDAO().getRequestByID(Integer.parseInt(reqID));
                    request.setAttribute("requestForm", reqForm);

                    break;
                case "5":

                    // 3 case : Lay Form len --- Reload update --- Reload create
                    if (flag == null)
                    {

                        Transaction trans = new TransactionDAO().getTransByID(Integer.parseInt(itemID));
                        formList = trans;

//                        test 
                        request.setAttribute("sec", sec);
                        request.setAttribute("formList", formList);
                        request.getRequestDispatcher("mainController?action=" + CONSTANTS.VIEWPRODUCT_ADMIN).forward(request, response);

                    } else if (flag.equals("reloadUpdate"))
                    {

                        String transForm = request.getParameter("formTranIDReload");
                        String proForm = request.getParameter("formProductReload");
                        String quantForm = request.getParameter("formQuantityReload");
                        Transaction oldTransForm = new TransactionDAO().getTransByID(Integer.parseInt(transForm));
                        Transaction trans = new Transaction(oldTransForm.getTranID(), oldTransForm.getDate(), Integer.parseInt(quantForm), oldTransForm.getMoney(), oldTransForm.getStatus(), new ProductDAO().getProductByID(proForm));
                        formList = trans;

                    } else if (flag.equals("reloadCreate"))
                    {
                        String proForm = request.getParameter("formProductReload");
                        String quantForm = request.getParameter("formQuantityReload");
                        Product pro = new ProductDAO().getProductByID(proForm);
                        Transaction trans = new Transaction(1, new Date(), Integer.parseInt(quantForm), pro.getPrice() * Integer.parseInt(quantForm), "1", pro);
                        formList = trans;
                        request.setAttribute("createFlag", "alert");
                    }
                    break;

                case "6":
                    String transID = request.getParameter("transID");
                    Transaction formTransaction = new TransactionDAO().getTransByID(Integer.parseInt(transID));
                    formList = formTransaction;

                    break;
                case "7":

                    out.print("====FORM====");

                    String serID = request.getParameter("serID");

                    out.print("serID: " + serID);
                    formList = new ServiceDAO().getServiceByID(Integer.parseInt(serID));

                    break;

            }
            request.setAttribute("sec", sec);
            request.setAttribute("formList", formList);

            request.getRequestDispatcher("mainController?action=" + CONSTANTS.VIEWPRODUCT_ADMIN).forward(request, response);

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
