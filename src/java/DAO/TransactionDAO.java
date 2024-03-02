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
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

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
                        int prdID= table.getInt("prd_ID");
                        Product prd= new ProductDAO().getProductByID(prdID+"");
                        //end===========================
                        trans = new Transaction(tranID, date, money, status, prd);
                        

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
}
