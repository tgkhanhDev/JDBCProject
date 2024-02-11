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
    
    public final String GETPRODUCTS = "getProducts"; // get products xong mới render qua products
    public final String VIEWPRODUCTS = "products"; // qua trang products

    public final String APPLICATION = "application"; // qua trang viết đơn

}
