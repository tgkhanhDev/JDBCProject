/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import DTO.Account;
import DTO.Service;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import mylibs.DBUtils;

/**
 *
 * @author ACER
 */
public class AccountDAO {

    public Account getClientAccount(String phone, String gmail, String pass) {
        Account rs = null;
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String s = "SELECT [AccountID], [LastName], [FirstName], [Phone], [Gmail],[Password], [status], [PolicyStatus], Account.[RoleID],Role.RoleName ,[Script] FROM\n"
                        + "[dbo].[Account] JOIN [dbo].[Role] ON [dbo].[Account].[RoleID] = [dbo].[Role].RoleID\n"
                        + "where (Account.Phone = ? and  Account.Password like  ? and Account.RoleID =1) or (Account.Gmail like ? and  Account.Password = ? and Account.RoleID != 1) ";
                PreparedStatement pst = cn.prepareStatement(s);
                pst.setString(1, phone);
                pst.setString(2, pass);
                pst.setString(3, gmail);
                pst.setString(4, pass);
                ResultSet table = pst.executeQuery();

                if (table != null && table.next()) {
                    int s_accid = table.getInt("AccountID");
                    String s_lastName = table.getString("LastName");
                    String s_firstName = table.getString("FirstName");
                    String s_lphone = table.getString("Phone");
                    String s_gmail = table.getString("Gmail");
                    String s_password = table.getString("Password");
                    String s_status = (table.getBoolean("status")) ? "1" : "0";
                    String s_policystatus = (table.getBoolean("status")) ? "1" : "0";
                    String s_roleName = table.getString("RoleName");
                    String s_script = table.getString("Script");
                    rs = new Account(s_accid, s_lastName, s_firstName, phone, s_gmail, s_password, s_status, s_policystatus, s_roleName, s_script);
                };
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {

            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return rs;
    }

    //getaccount:
    public ArrayList<Account> getAllAccount() {
        ArrayList<Account> list = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "SELECT [AccountID],[LastName],[FirstName], [Phone],[Gmail],[Password],[status], [PolicyStatus],[dbo].[Role].RoleName,[Script] FROM [dbo].[Account]\n"
                        + "JOIN [dbo].[Role] ON [dbo].[Account].[RoleID] = [dbo].[Role].RoleID";
                Statement st = cn.createStatement();
                ResultSet table = st.executeQuery(sql);
                if (table != null) {
                    while (table.next()) {
                        int id = table.getInt("AccountID");
                        String lastName = table.getString("LastName");
                        String firstName = table.getString("FirstName");
                        String phone = table.getString("Phone");
                        String gmail = table.getString("Gmail");
                        String password = table.getString("Password");
                        String status = (table.getBoolean("status")) ? "1" : "0";
                        String policyStatus = (table.getBoolean("PolicyStatus")) ? "1" : "0";
                        String roleName = table.getString("RoleName");
                        String script = table.getString("Script");
                        list.add(new Account(id, lastName, firstName, phone, gmail, password, status, policyStatus, roleName, script));
                    }
                }

            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return list;
    }
    // check thu mail co ton tai trong sql ko neu co thi count se tang len

    public int checkMail(String gmail) {
        Connection cn = null;
        int count = 0;

        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "SELECT COUNT(*) as [count] from [dbo].[Account] where [Gmail] =?";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, gmail);
                ResultSet table = pst.executeQuery();
                if (table != null && table.next()) {
                    count = table.getInt("count");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return count;
    }

    public int checkPhone(String phone) {
        Connection cn = null;
        int count = 0;

        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "SELECT COUNT(*)as [count] from [dbo].[Account] where [Phone] = ?";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, phone);
                ResultSet table = pst.executeQuery();
                if (table != null && table.next()) {
                    count = table.getInt("count");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return count;
    }

    public int registerAccount(String lastName, String firstName, String phone, String gmail, String pass) {
        Connection cn = null;
        int result = 0;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "INSERT INTO [dbo].[Account]\n"
                        + "VALUES (?, ?, ?, ?, ?, 1, 1, 1, NULL);";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, lastName);
                pst.setString(2, firstName);
                pst.setString(3, phone);
                pst.setString(4, gmail);
                pst.setString(5, pass);
                 result = pst.executeUpdate();
                
            }
        } catch (Exception e) {
            e.printStackTrace();
        } 
        finally {
            try {
                if(cn!=null){
                cn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        
        }
        return result;
    }

}
