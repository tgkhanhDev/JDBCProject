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
public class Account {

    private int AccountID;
    private String LastName;
    private String FirstName;
    private String phone;
    private String gmail;
    private String password;
    private String status;
    private String policyStatus;
//    private int RoleID;
    private String RoleName;
    private String script;

    public Account() {
    }

    public Account(int AccountID, String LastName, String FirstName, String phone, String gmail, String password, String status, String policyStatus, String RoleName, String script) {
        this.AccountID = AccountID;
        this.LastName = LastName;
        this.FirstName = FirstName;
        this.phone = phone;
        this.gmail = gmail;
        this.password = password;
        this.status = status;
        this.policyStatus = policyStatus;
        this.RoleName = RoleName;
        this.script = script;
    }

    public int getAccountID() {
        return AccountID;
    }

    public void setAccountID(int AccountID) {
        this.AccountID = AccountID;
    }

    public String getLastName() {
        return LastName;
    }

    public void setLastName(String LastName) {
        this.LastName = LastName;
    }

    public String getFirstName() {
        return FirstName;
    }

    public void setFirstName(String FirstName) {
        this.FirstName = FirstName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getGmail() {
        return gmail;
    }

    public void setGmail(String gmail) {
        this.gmail = gmail;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getPolicyStatus() {
        return policyStatus;
    }

    public void setPolicyStatus(String policyStatus) {
        this.policyStatus = policyStatus;
    }

    public String getRoleName() {
        return RoleName;
    }

    public void setRoleName(String RoleName) {
        this.RoleName = RoleName;
    }

    public String getScript() {
        return script;
    }

    public void setScript(String script) {
        this.script = script;
    }

    
    
}
