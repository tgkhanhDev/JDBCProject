/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import DAO.AccountDAO;
import DAO.ContactDAO;
import DAO.ProductDAO;
import DAO.RequestDAO;
import DAO.RequestTypeDAO;
import DAO.ServiceDAO;
import DAO.StatusTypeDAO;
import DAO.TransactionDAO;
import DTO.Account;
import DTO.Contact;
import DTO.Product;
import DTO.ProductCategories;
import DTO.Request;
import DTO.RequestType;
import DTO.Role;
import DTO.Service;
import DTO.StatusType;
import DTO.Transaction;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import mylibs.DBUtils;

/**
 *
 * @author ACER
 */
public class AddController_Admin extends HttpServlet {

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
            /*Update trong ADMIN*/
            String sec = (String) request.getParameter("sec");
            out.print("<h1>sec: " + sec + "</h1>");

            int result = 0;
            switch (sec)
            {
                case "1":
                    String name = (String) request.getParameter("name");
                    String thumbnail = (String) request.getParameter("thumbnail");
                    String description = (String) request.getParameter("description");
                    int price = Integer.parseInt(request.getParameter("price"));
                    int speed = Integer.parseInt(request.getParameter("speed"));
                    int cate_ID = Integer.parseInt(request.getParameter("cate_ID"));
                    ProductCategories prdC = new ProductDAO().getCateByID(cate_ID);
                    String status = (String) request.getParameter("status");
                    Product prd = new Product(0, name, thumbnail, description, price, speed, prdC, status);
                    result = new ProductDAO().addProduct(prd);
                    break;
                case "2":
                    String lastName = (String) request.getParameter("LastName");
                    String firstName = (String) request.getParameter("FirstName");
                    String phone = (String) request.getParameter("phone");
                    String gmail = (String) request.getParameter("gmail");
                    String password = (String) request.getParameter("password");
                    String status_acc = (String) request.getParameter("status");
                    String policyStatus = (String) request.getParameter("policyStatus");
                    String RoleID = (String) request.getParameter("RoleID");
                    Role role = new AccountDAO().getRoleByID(Integer.parseInt(RoleID));
                    String script = (String) request.getParameter("script");
                    String sex = (String) request.getParameter("sex");
                    Account acc = new Account(0, lastName, firstName, phone, gmail, password, sex, status_acc, policyStatus, role, script);
                    result = new AccountDAO().AddAccount(acc);
                    break;
                case "3":
                    //Tạo Transaction (stt false) => Tạo Contact (status false) => Tạo Request
                    //Admin chỉ có thể tạo rq để sửa chữa, k thể tạo đơn mua hàng => ko cần tạo Transaction.

                    //Từ Contract => Request phải cần set Status trước
                    //Hướng tư duy: Admin tạo Transaction Với prd bằng Null
                    String accPhone = request.getParameter("AccountPhone");
                    String managerID = request.getParameter("ManagerID");

                    String serID = request.getParameter("SerID");
                    String reqTypeID = request.getParameter("reqTypeID");
                    String Description = request.getParameter("Description");

                    //Admin nên prd phải null
                    Transaction trans = new Transaction(0, new Date(), 0, 0, "1", null);
                    int rsTrans = new TransactionDAO().addNewTransactionForCreateRequest(trans);
                    if (rsTrans > 0)
                    {
                        Contact contract = new Contact(0, new ServiceDAO().getServiceByID(Integer.parseInt(serID)), trans, "1");
                        int rsContract = new ContactDAO().addContactForRequest(contract);

                        if (rsContract > 0)
                        {
                            AccountDAO accDAO = new AccountDAO();
                            StatusType defaulStatus = new StatusTypeDAO().getStatusTypeByID(2); // Đã xn
                            Request rq = new Request(0, accDAO.getAccountByPhone(accPhone).get(0), accDAO.getAccountByID(managerID), contract, defaulStatus, new RequestTypeDAO().getRequestTypeByID(Integer.parseInt(reqTypeID)), Description);
                            result = new RequestDAO().addRequest(rq);
                        }
                    }

                    //Render lại Layout... Price, ...
                    
                    break;
                case "5":
                    String date = request.getParameter("dateForm");
                    int quantity = Integer.parseInt(request.getParameter("quantity"));
                    int prdID_5 = Integer.parseInt(request.getParameter("prdID"));
                    int totalPrice = new ProductDAO().getProductByID(prdID_5 + "").getPrice() * quantity;
                    result = new TransactionDAO().addNewTransaction(date, quantity, totalPrice, prdID_5);
                    break;

                case "6":
                    String transactionForm = request.getParameter("transactionForm");
                    String serviceForm = request.getParameter("serviceForm");
                    result = new ContactDAO().addContract_Form(transactionForm, serviceForm);

                    break;
                    
                case "7":
                    String serName = request.getParameter("serName");
                    int price7 = Integer.parseInt(request.getParameter("price"));
                    result = new ServiceDAO().addService(serName, price7);
                    
                    break;
            }
            
            if (result >= 1)
            {
                request.getRequestDispatcher("mainController?action=" + CONSTANTS.GETPRODUCT_ADMIN).forward(request, response);
            } else
            {
                out.print("Some thing Wronggggggggggg");
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
