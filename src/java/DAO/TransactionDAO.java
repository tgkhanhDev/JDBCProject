/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import DTO.Product;
import DTO.ProductCategories;
import DTO.Transaction;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import mylibs.DBUtils;

/**
 *
 * @author ACER
 */
public class TransactionDAO {

    //Add Utils
    public java.util.Date convertStringToDate(String dateString) throws ParseException {
        java.util.Date date;
        // validation  
        try
        {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

            date = sdf.parse(dateString);
            return date;
        } catch (Exception e)
        {
            e.printStackTrace();
        }
        return null;
    }
    //====

    public Transaction getTransByID(int id) {
        Transaction trans = null;
        Connection cn = null;
        try
        {
            cn = DBUtils.makeConnection();
            if (cn != null)
            {
                String sql = "SELECT [TranID] ,[Date], [money],[Status], [prd_ID] FROM [dbo].[Transaction_infor]"
                        + "WHERE [TranID] = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, id);
                ResultSet table = st.executeQuery();
                if (table != null)
                {
                    while (table.next())
                    {
                        int tranID = table.getInt("TranID");
                        java.util.Date date = convertStringToDate(table.getString("Date"));
                        double money = table.getDouble("money");
                        String status = (table.getBoolean("Status")) ? "1" : "0";
                        //getPrdObj
                        int prdID = table.getInt("prd_ID");
                        Product prd = new ProductDAO().getProductByID(prdID + "");
                        //end===========================
                        
                        //bug
                        trans = new Transaction(tranID, date, 1 , money, status, prd);

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
        return trans;
    }

    //POST UPDATE=======================================================================:
    public int addNewTransaction(Transaction trans) {
        Connection cn = null;
        int result = 0;
        try
        {
            cn = DBUtils.makeConnection();
            if (cn != null)
            {
                String sql = "INSERT INTO [dbo].[Transaction_infor] ([Date],[money],[Status],[prd_ID])\n"
                        + "VALUES (?, ?, ?, ?) ";
                PreparedStatement pst = cn.prepareStatement(sql);
                if (trans.getDate() != null)
                {
                    pst.setTimestamp(1, new java.sql.Timestamp(trans.getDate().getTime()));
                } else
                {
                    pst.setDate(1, null);
                }
                pst.setDouble(2, trans.getMoney());
                pst.setString(3, trans.getStatus());

                if (trans.getProduct().getPrd_ID() == 0)
                {
                    pst.setString(4, null);
                } else
                {
                    pst.setInt(4, trans.getProduct().getPrd_ID());
                }

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
