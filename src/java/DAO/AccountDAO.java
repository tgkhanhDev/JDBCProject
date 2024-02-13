/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import DTO.Account;
import DTO.Service;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import mylibs.DBUtils;

/**
 *
 * @author ACER
 */
public class AccountDAO {

    //getaccount:
    public ArrayList<Account> getAllAccount() {
        ArrayList<Account> list = new ArrayList<>();
        Connection cn = null;
        try
        {
            cn = DBUtils.makeConnection();
            if (cn != null)
            {
                String sql = "SELECT [AccountID],[LastName],[FirstName], [Phone],[Gmail],[Password],[status], [PolicyStatus],[dbo].[Role].RoleName,[Script] FROM [dbo].[Account]\n"
                        + "JOIN [dbo].[Role] ON [dbo].[Account].[RoleID] = [dbo].[Role].RoleID";
                Statement st = cn.createStatement();
                ResultSet table = st.executeQuery(sql);
                if (table != null)
                {
                    while (table.next())
                    {
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

        return list;
    }
}
