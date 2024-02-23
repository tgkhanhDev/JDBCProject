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

    //Get => Qua controller lay database
    //view => Qua JSP
    // ?action=...
    public final String GETHOME = "gethome"; //back to  homeController: (getdata before go home)
    public final String VIEWHOME = "home"; //back to home: index.jsp

  
    
    public final String GETLOGINPAGE = "getloginpage"; //back to  loginController: )
    public final String VIEWLOGINPAGE = "loginpage"; //back to loginpage
    
      public final  String GETSIGNUP = "getsignup";// go to registerContrller to check account exit    
     public final  String GETSIGNIN = "getsignin"; //back to signinController (xu ly data khi mà login dữ liệu vào)
     
    public final String GETHOMEPAGELOGIN="gethomepagelogin";  
    public final String VIEWHOMEPAGELOGIN="homepagelogin"; // vào trang chủ sau khi đăng nhập thành công
    
    public final String VIEWPROFILE =""; //
    
    public final String GETPRODUCTS = "getProducts"; // get products xong mới render qua products
    public final String VIEWPRODUCTS = "products"; // qua trang products

    public final String APPLICATION = "application"; // qua trang viết đơn

    //admin
    public final String GETPRODUCT_ADMIN = "getProductAdmin"; // Lấy thông tin admin
    public final String VIEWPRODUCT_ADMIN = "productAdmin"; // qua trang Admin
}
