/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import DAO.AccountDAO;
import DAO.ProductDAO;
import DTO.Account;
import DTO.Product;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
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
            sec = "2";
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
                    String status = (String) request.getParameter("status");
                    Product prd = new Product(0, name, thumbnail, description, price, speed, cate_ID, status);
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
                    String RoleName = new AccountDAO().getRoleByID(RoleID);
                    String script = (String) request.getParameter("script");
                    //                    int acc_ID = 1;
//                    String firstName = "Shelby";
//                    String lastName = "Tommy";
//                    String phone = "093213214";
//                    String gmail = "bongmaanhquoc@gmail.com";
//                    String password = "peakyblinder";
//                    String status_acc = "1";
//                    String policyStatus = "1";
//                    String RoleName = "Client";
//                    String script = "Tao bắn mày á";
                    Account acc = new Account(0, lastName, firstName, phone, gmail, password, status_acc, policyStatus, RoleName, script);
//                    result = new AccountDAO().AddAccount(acc);
                    //======================
                    //Tại sao mk bị truncated?
                    Connection cn = null;
                    try
                    {
                        cn = DBUtils.makeConnection();
                        if (cn != null)
                        {
                            String sql
                                    = "INSERT INTO [dbo].[Account] ([LastName],[FirstName],[Phone],[Gmail],[Password],[status],[PolicyStatus],[RoleID],[Script])\n"
                                    + "VALUES ("
                                    + "?" //1
                                    + ",?" //2
                                    + ",?"//3
                                    + ",?"//4
                                    + ",?"//5
                                    + ",?"//6
                                    + ",?"//7
                                    + ",(SELECT [dbo].[Role].[RoleID] FROM [dbo].[Role]\n"
                                    + "Where [dbo].[Role].RoleName = ? )" //8
                                    + ",?)"; //9

                            PreparedStatement pst = cn.prepareStatement(sql);
                            pst.setString(1, acc.getLastName());
                            pst.setString(2, acc.getFirstName());
                            pst.setString(3, acc.getPhone());
                            pst.setString(4, acc.getGmail());
                            pst.setString(5, acc.getPassword());
                            pst.setString(6, acc.getStatus());
                            pst.setString(7, acc.getPolicyStatus());
                            pst.setString(8, acc.getRoleName());
                            pst.setString(9, acc.getScript());

                            //Tra ve 0/1
                            result = pst.executeUpdate();
                        }
                    } catch (Exception e)
                    {
                        e.printStackTrace();
                    } finally
                    {
                        try
                        {
                            if (cn != null)
                            {
                                cn.close();
                            }
                        } catch (Exception e)
                        {
                            e.printStackTrace();
                        }
                    }
                    //======================

                    break;
            }

//            int prd_ID = Integer.parseInt(request.getParameter("prd_ID"));
//            out.print("<div>"+prd_ID+"</div>");
//            out.print("<div>" + name + "</div>");
//            out.print("<div>" + thumbnail + "</div>");
//            out.print("<div>" + description + "</div>");
//            out.print("<div>" + price + "</div>");
//            out.print("<div>" + speed + "</div>");
//            out.print("<div>" + cate_ID + "</div>");
//            out.print("<div>" + status + "</div>");
            if (result >= 1)
            {
                request.getRequestDispatcher("mainController?action=" + CONSTANTS.GETPRODUCT_ADMIN).forward(request, response);
            } else
            {
                out.print("Some thing Wrong");
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
