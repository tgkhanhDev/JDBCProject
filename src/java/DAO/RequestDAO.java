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
import DTO.Role;
import DTO.StatusType;
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

    public ArrayList<Request> getSortRequest(String dateSort, String phoneSearch, String status) {
        ArrayList<Request> list = new ArrayList<>();
        Connection cn = null;
        try
        {
            cn = DBUtils.makeConnection();
            if (cn != null)
            {
                String s = "DECLARE @SortOrder varchar = ?\n"
                        + "SELECT [ReqID], R.[AccountID],[ManagerAccountID] , R.[ContactID] ,R.[StatusID], [reqTypeID], [Description] FROM [dbo].[Request] as R\n"
                        + "JOIN [dbo].[Account] as A ON R.[AccountID] = A.[AccountID]\n"
                        + "JOIN [dbo].[StatusType] as ST ON R.[StatusID] = ST.[StatusID]\n"
                        + "JOIN [dbo].[Contact] as C ON R.[ContactID] = C.[ContactID]\n"
                        + "JOIN [dbo].[Transaction_infor] as T ON C.[TranID] =  T.[TranID]\n"
                        + "WHERE A.Phone like ?\n"
                        + "AND ST.[StatusID] like ?\n"
                        + "ORDER BY\n"
                        + "    CASE WHEN @SortOrder = 'asc' THEN T.Date END ASC,\n"
                        + "    CASE WHEN @SortOrder = 'desc' THEN T.Date END DESC;";
                PreparedStatement pst = cn.prepareStatement(s);
                pst.setString(1, dateSort);
                pst.setString(2, "%" + phoneSearch + "%");
                pst.setString(3, "%" + status + "%");
                ResultSet table = pst.executeQuery();

                if (table != null && table.next())
                {

                };
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
    //POST UPDATE=======================================================================:

    public int addRequest(Request request) {
        int result = 0;
        Connection cn = null;
        try
        {
            cn = DBUtils.makeConnection();
            if (cn != null)
            {

                String sql
                        = "INSERT INTO [dbo].[Request]([AccountID],[ManagerAccountID],[ContactID],[StatusID],[reqTypeID],[Description])\n"
                        + "VALUES (?,?,(SELECT Max([ContactID]) FROM [dbo].[Contact]),?,?,?)";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, request.getAcc().getAccountID());
                pst.setInt(2, request.getAdminAcc().getAccountID());
                pst.setInt(3, request.getStatusType().getStatusID());
                pst.setInt(4, request.getRequestType().getRqTyID());
                pst.setString(5, request.getDescription());

                //Tra ve 0/1
                result = pst.executeUpdate();

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

        return result;
    }

}
