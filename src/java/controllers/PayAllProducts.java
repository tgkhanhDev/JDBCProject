/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

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
import DTO.Request;
import DTO.RequestType;
import DTO.Service;
import DTO.Transaction;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
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
public class PayAllProducts extends HttpServlet {

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
            out.println("<h1>Servlet PayAllProducts at " + request.getContextPath() + "</h1>");
            HttpSession session = request.getSession();
            HashMap<String, Integer> cart = (HashMap<String, Integer>) session.getAttribute("cartList");

            Account acc = (Account) session.getAttribute("loginUser");
            out.print("<h3>" + acc.getLastName() + "</h3>");

            boolean blackFlag = false;

            if (cart != null)
            {
                for (Map.Entry<String, Integer> entry : cart.entrySet())
                {
                    int transRS = 0;
                    int contactRS = 0;
                    int reqFlag = 0;

                    Date date = new Date();
                    Product prd = new ProductDAO().getProductByID(entry.getKey());
                    double money = prd.getPrice() * entry.getValue() * 1.0;
                    int quantity = entry.getValue();

                    Transaction trans = new Transaction(0, date, quantity, money, "0", prd);
                    transRS = new TransactionDAO().addNewTransaction(trans);

                    if (transRS > 0)
                    {
                        Service ser = new ServiceDAO().getServiceByID(3); // 3 là mua hàng
                        Contact contact = new Contact(0, ser, trans, "0");

                        contactRS = new ContactDAO().addContactForRequest(contact);

                        if (contactRS > 0)
                        {
                            Request req = new Request(0, acc, null, contact, new StatusTypeDAO().getStatusTypeByID(1), new RequestTypeDAO().getRequestTypeByID(3), "Mua đồ!");
                            reqFlag = new RequestDAO().addRequestForClient(req);
                            if (reqFlag <= 0)
                            {
                                blackFlag = true;
                            }
                        } else
                        {
                            blackFlag = true;
                        }
                    } else
                    {
                        blackFlag = true;
                    }

                    if (blackFlag == true)
                    {
                        out.print("<h1>Oops, Error" + "</h1>");
                        out.print("<h1>transRS: " + transRS + "</h1>");
                        out.print("<h1>contactRS: " + contactRS + "</h1>");
                        out.print("<h1>reqFlag: " + reqFlag + "</h1>");

                    } else
                    {
                        session.removeAttribute("cartList");
                        session.removeAttribute("totalCartItems");
                        request.setAttribute("message", "Thanh toán thành công");
                        request.getRequestDispatcher("mainController?action=" + CONSTANTS.GETPRODUCTS).forward(request, response);
                    }
                }
            } else
            {
                out.print("Nothing to buy...");
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
