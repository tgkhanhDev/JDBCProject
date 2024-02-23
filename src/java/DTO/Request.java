/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DTO;

/**
 *
 * @author ACER
 */
public class Request {

    private int ReqID;
    private int AccountID;
    private int ContactID;
    private String Status;
    private int reqTypeID;
    private String Description;

    public Request(int ReqID, int AccountID, int ContactID , String Status, int reqTypeID, String Description) {
        this.ReqID = ReqID;
        this.AccountID = AccountID;
        this.ContactID = ContactID;
        this.Status = Status;
        this.reqTypeID = reqTypeID;
        this.Description = Description;
    }

    public int getReqID() {
        return ReqID;
    }

    public void setReqID(int ReqID) {
        this.ReqID = ReqID;
    }

    public int getAccountID() {
        return AccountID;
    }

    public void setAccountID(int AccountID) {
        this.AccountID = AccountID;
    }

    public String getStatus() {
        return Status;
    }

    public void setStatus(String Status) {
        this.Status = Status;
    }

    public int getReqTypeID() {
        return reqTypeID;
    }

    public void setReqTypeID(int reqTypeID) {
        this.reqTypeID = reqTypeID;
    }

    public String getDescription() {
        return Description;
    }

    public void setDescription(String Description) {
        this.Description = Description;
    }

    public int getContactID() {
        return ContactID;
    }

    public void setContactID(int ContactID) {
        this.ContactID = ContactID;
    }

}
