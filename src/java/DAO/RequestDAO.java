/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import DTO.Account;
import DTO.Request;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import mylibs.DBUtils;

/**
 *
 * @author ACER
 */
public class RequestDAO {
    //Get Req:

    public ArrayList<Request> getAllRequest() {
        ArrayList<Request> list = new ArrayList<>();
        Connection cn = null;
        try
        {
            cn = DBUtils.makeConnection();
            if (cn != null)
            {
                String sql = "SELECT [ReqID],[AccountID],[ContactID],[Status],[reqTypeID],[Description] FROM [dbo].[Request]";
                Statement st = cn.createStatement();
                ResultSet table = st.executeQuery(sql);
                if (table != null)
                {
                    while (table.next())
                    {
                        int ReqID = table.getInt("ReqID");
                        int AccountID = table.getInt("AccountID");
                        int ContactID = table.getInt("ContactID");
                        String Status = table.getString("Status");
                        int reqTypeID = table.getInt("reqTypeID");
                        String Description = table.getString("Description");
                        list.add(new Request(ReqID, AccountID, ContactID, Status, reqTypeID, Description));
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
