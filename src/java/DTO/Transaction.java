/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DTO;

import java.util.Date;

/**
 *
 * @author ACER
 */
public class Transaction {
    private int TranID;
    private Date date; //Ngay giao dich
//    private Date time;// TG 
    private double money;
    private String status;
    private Product product; //FK

    public Transaction(int TranID, Date date, double money, String status, Product product) {
        this.TranID = TranID;
        this.date = date;
        this.money = money;
        this.status = status;
        this.product = product;
    }

    public int getTranID() {
        return TranID;
    }

    public void setTranID(int TranID) {
        this.TranID = TranID;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public double getMoney() {
        return money;
    }

    public void setMoney(double money) {
        this.money = money;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

}