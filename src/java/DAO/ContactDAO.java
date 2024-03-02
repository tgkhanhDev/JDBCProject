/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import DTO.Contact;
import DTO.Service;
import DTO.Transaction;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import mylibs.DBUtils;

/**
 *
 * @author ACER
 */
public class ContactDAO {

    public Contact getContactByID(int id) {
        Contact rs = null;
        Connection cn = null;
        try
        {
            cn = DBUtils.makeConnection();
            if (cn != null)
            {
                String sql = "SELECT [ContactID], [SerID] , [TranID],[status]  FROM [dbo].[Contact]\n"
                        + "WHERE [dbo].[Contact].[ContactID] = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, id);
                ResultSet table = st.executeQuery();
                if (table != null)
                {
                    while (table.next())
                    {
                        int contactID = table.getInt("ContactID");
                        //get SerObj
                        int serID = table.getInt("SerID");
                        Service ser = new ServiceDAO().getServiceByID(serID);
                        //end SerObj
                        int tranID = table.getInt("TranID");
                        Transaction trans = new TransactionDAO().getTransByID(tranID);
                        String status = (table.getBoolean("status")) ? "1" : "0";
                        rs = new Contact(contactID, ser, trans, status);
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
        return rs;
    }

}