package controllers;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import DAO.AccountDAO;
import DAO.ContactDAO;
import DAO.ProductDAO;
import DAO.RequestDAO;
import DAO.ServiceDAO;
import DAO.StatusTypeDAO;
import DAO.TransactionDAO;
import DTO.Account;
import DTO.Product;
import DTO.Service;
import DTO.Transaction;
import controllers.CONSTANTS;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

/**
 *
 * @author ACER
 */
public class AdminController_Admin extends HttpServlet {

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
            ArrayList list = new ArrayList();
            int size = 0;

            HttpSession session = request.getSession();

            String sec = request.getParameter("sec");
            String search = request.getParameter("search");

            //dành cho việc chia pagination trên sql
            String jstlFlag = null;
            int jstlSize = 0;
            //currentPage:
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
                    if (search != null)
                    {
                        list = new ProductDAO().getProductByName(search);
                    } else
                    {
                        list = new ProductDAO().getAllProduct();
                    }
                    break;
                case "2":
                    if (search != null)
                    {
                        list = new AccountDAO().getAccountByPhone(search);
                    } else
                    {
                        list = new AccountDAO().getAllAccount();
                    }
                    break;
                case "3":

                    session.setAttribute("statusList", new StatusTypeDAO().getAllStatusType());
                    //========================================
                    String date = request.getParameter("date");
                    String status = request.getParameter("status");
                    date = (date == null || date.trim().equals("null")) ? date = "1" : date;
                    status = (status == null || status.trim().equals("null")) ? "" : status;
                    search = (search == null || search.trim().equals("null")) ? "" : search;

                    list = new RequestDAO().getSortRequest(date, search, status);
                    request.setAttribute("date", date);
                    request.setAttribute("status", status);
                    //========================================
                    break;

                case "4":
                    Account acc = (Account) session.getAttribute("loginUser");
                    if (acc != null)
                    {
                        String date4 = request.getParameter("date");
                        String status4 = request.getParameter("status");
                        date4 = (date4 == null || date4.trim().equals("null")) ? date = "1" : date4;
                        status4 = (status4 == null || status4.trim().equals("null")) ? "" : status4;
                        search = (search == null || search.trim().equals("null")) ? "" : search;
                        list = new RequestDAO().getSortRequestByManagerID(date4, search, status4, acc.getAccountID());
                    }
                    ArrayList<Account> technicianList = new AccountDAO().getAllTechnician();
                    session.setAttribute("technicianList", technicianList);

                    break;
                case "5":
                    //Transaction
                    String status5 = request.getParameter("status");
                    String date5 = request.getParameter("date");
                    status5 = (status5 == null || status5.trim().equals("null")) ? "" : status5;
                    date5 = (date5 == null || date5.trim().equals("null")) ? "" : date5;

                    ArrayList<Product> prdList = new ProductDAO().getAllProduct();
                    session.setAttribute("prdList", prdList);

                    list = new TransactionDAO().getAllTransactionPagination(status5, date5, currPage);

                    //setFlag for anotherSize method:
                    jstlFlag = "alter";
                    jstlSize = new TransactionDAO().countTransaction();
                    break;
                case "6":

                    String status6 = request.getParameter("status");
                    String transID6 = request.getParameter("transID");
                    status6 = (status6 == null || status6.trim().equals("null")) ? "" : status6;
                    transID6 = (transID6 == null || transID6.trim().equals("null")) ?  "" : transID6;

                    list = new ContactDAO().getAllContactPagination(status6, transID6, currPage);
                    ArrayList<Transaction> formTransList = new TransactionDAO().getAllTransaction();
                    ArrayList<Service> formServiceList = new ServiceDAO().getAllService();
                    session.setAttribute("formTransList", formTransList);
                    session.setAttribute("formServiceList", formServiceList);
                    
                    //setFlag for anotherSize method:
                    jstlFlag = "alter";
                    jstlSize = new ContactDAO().countContract();
                    break;
                    
                case "7":
                    list = new ServiceDAO().getAllService();
                    break;
            }
            request.setAttribute("sec", sec);
            session.setAttribute("list", list);

            size = list.size();
            //Vì phương pháp sd jstl, tôi đã chia sẵn mảng ở trong Sql,
            //mà pagination của tôi lại phân trang theo tổng phần tử 
            // => tôi phải lấy size bằng cách khác
            if (jstlFlag == null)
            {
                session.setAttribute("size", size);
            } else
            {
                session.setAttribute("size", jstlSize);
            }
//            request.setAttribute("list", list);

            //            Về view nè 
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
