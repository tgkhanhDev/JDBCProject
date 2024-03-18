/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import DTO.Contact;
import DTO.Product;
import DTO.Service;
import DTO.Transaction;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import mylibs.DBUtils;
import mylibs.UtilsFunc;

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

    //POST UPDATE=======================================================================:
    public int addContact(Contact contact) {
        int result = 0;
        Connection cn = null;
        try
        {
            cn = DBUtils.makeConnection();
            if (cn != null)
            {

                String sql
                        = "INSERT INTO [dbo].[Contact]([SerID],[TranID],[status])\n"
                        + "VALUES (?,(SELECT MAX(TranID) FROM [dbo].[Transaction_infor]),?)";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, contact.getService().getId());
                pst.setString(2, contact.getStatus());

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

    public ArrayList<Contact> getAllContactPagination(String status, String transID, String page) {
        ArrayList<Contact> list = new ArrayList();
        Connection cn = null;
        try
        {
            cn = DBUtils.makeConnection();
            if (cn != null)
            {
                String sql = "DECLARE @searchSTT NVARCHAR(10) = ?\n"
                        + "DECLARE @transID NVARCHAR(10) = ?\n"
                        + "DECLARE @page NVARCHAR(15) = ?\n"
                        + ";WITH ContractTbl AS(\n"
                        + "	SELECT [ContactID],[SerID],[TranID],[status],ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS 'rowNumber' FROM [dbo].[Contact]\n"
                        + "	 WHERE ([Status] LIKE @searchSTT OR @searchSTT = '')\n"
                        + "	 AND ([TranID] LIKE @transID or @transID ='' )\n"
                        + ")\n"
                        + "SELECT * FROM ContractTbl\n"
                        + "WHERE [rowNumber] BETWEEN @page AND (@page+5)";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, status);
//                Lay trong vong 7 ngay 
                pst.setString(2, transID);
                pst.setString(3, (Integer.parseInt(page) - 1) * 5 + "");
                ResultSet table = pst.executeQuery();
                if (table != null)
                {
                    while (table.next())
                    {
                        int contactID = table.getInt("ContactID");
                        int serviceID = table.getInt("SerID");
                        Service service = new ServiceDAO().getServiceByID(serviceID);
                        int tranID = table.getInt("TranID");
                        Transaction transaction = new TransactionDAO().getTransByID(tranID);
                        String statusRS = (table.getBoolean("status")) ? "1" : "0";

                        list.add(new Contact(contactID, service, transaction, statusRS));
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

    public int countContract() {
        int result = 0;
        Connection cn = null;
        try
        {
            cn = DBUtils.makeConnection();
            if (cn != null)
            {
                String sql
                        = "SELECT count(*) as [rowSize] FROM [dbo].[Contact]";

                Statement st = cn.createStatement();
                ResultSet table = st.executeQuery(sql);
                if (table != null)
                {
                    while (table.next())
                    {
                        result = table.getInt(1);
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
        return result;
    }

    public int updateContractStatus(int id) {
        int result = 0;
        Connection cn = null;
        try
        {
            cn = DBUtils.makeConnection();
            if (cn != null)
            {
                String sql
                        = "UPDATE [dbo].[Contact]\n"
                        + "SET [status] = ~[status]\n"
                        + "WHERE [ContactID] = ? ";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, id);

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

    public int addContract_Form(String transaction, String service) {
        int result = 0;
        Connection cn = null;
        try
        {
            cn = DBUtils.makeConnection();
            if (cn != null)
            {
                String sql
                        = "INSERT INTO [dbo].[Contact] ([SerID],[TranID],[status])\n"
                        + "VALUES(?, ?,1)"; //9

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1,  transaction);
                pst.setString(2, service);
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
