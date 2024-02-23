/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

/**
 *
 * @author ACER
 */
public interface CONSTANTS {
    
    public final int MAXPAGE_ADMIN=5;
    
    
    //Get => Qua controller lay database
    //view => Qua JSP
    // ?action=...
    public final String GETHOME = "gethome"; //back to  homeController: (getdata before go home)
    public final String VIEWHOME = "home"; //back to home: index.jsp

    public final String GETLOGINPAGE = "getloginpage"; //back to  loginController: )
    public final String VIEWLOGINPAGE = "loginpage"; //back to loginpage

    public final String GETPRODUCTS = "getProducts"; // get products xong mới render qua products
    public final String VIEWPRODUCTS = "products"; // qua trang products

    public final String APPLICATION = "application"; // qua trang viết đơn

    //admin
    public final String GETPRODUCT_ADMIN = "getProductAdmin"; // Lấy thông tin admin
    public final String VIEWPRODUCT_ADMIN = "productAdmin"; // qua trang Admin

    public final String GETFORMINFOPRODUCT_ADMIN = "formHandle"; // qua trang Admin
    public final String UPDATEINFO_ADMIN = "updateAdmin"; // Qua update Servlet
    public final String ADDINFO_ADMIN = "addAdmin"; // qua Add Servlet
    public final String BLOCK_ADMIN = "blockAdmin"; // qua Add Servlet

}
