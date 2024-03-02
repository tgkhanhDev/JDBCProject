/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import DTO.Account;
import DTO.Contact;
import DTO.Request;
import DTO.RequestType;
import DTO.StatusType;
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
                String sql = "SELECT [ReqID], [AccountID],[ManagerAccountID] ,[ContactID],[StatusID], [reqTypeID], [Description] FROM [dbo].[Request] ";
                Statement st = cn.createStatement();
                ResultSet table = st.executeQuery(sql);
                if (table != null)
                {
                    while (table.next())
                    {
                        int ReqID = table.getInt("ReqID");
                        //getAccObj
                        int accID = table.getInt("AccountID");
                        Account account = new AccountDAO().getAccountByID(accID + "");
                        //end accobj

                        //getAdminAccObj
                        int adminAccID = table.getInt("ManagerAccountID");
                        Account adminAcc = new AccountDAO().getAccountByID(adminAccID + "");
                        //end accobj

                        //getContactObj
                        int contactID = table.getInt("ContactID");
                        Contact contact = new ContactDAO().getContactByID(contactID);
                        //end contactobj

                        int statusID = table.getInt("StatusID");
                        StatusType statusType = new StatusTypeDAO().getStatusTypeByID(statusID);

                        //getReqObj
                        int reqTypeID = table.getInt("reqTypeID");
                        RequestType rqt = new RequestTypeDAO().getRequestTypeByID(reqTypeID);
                        //=========

                        String Description = table.getString("Description");

                        list.add(new Request(ReqID, account, adminAcc, contact, statusType, rqt, Description));

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