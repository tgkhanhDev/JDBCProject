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
import java.util.ArrayList;
import mylibs.DBUtils;
import mylibs.UtilsFunc;

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

    public ArrayList<Transaction> getAllTransaction(String status, String date, String page) {
        ArrayList<Transaction> list = new ArrayList();
        Connection cn = null;
        try
        {
            cn = DBUtils.makeConnection();
            if (cn != null)
            {
                String sql = "DECLARE @searchSTT NVARCHAR(10) = ?\n"
                        + "DECLARE @dateSearch NVARCHAR(15) = ?\n"
                        + "DECLARE @page NVARCHAR(15) = ?\n"
                        + ";WITH transactions AS (\n"
                        + "    SELECT [TranID], [Date], [quantity], [money], [Status], [prd_ID],\n"
                        + "        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS 'rowNumber'\n"
                        + "    FROM [dbo].[Transaction_infor]\n"
                        + "    WHERE ([Status] LIKE @searchSTT OR @searchSTT = '')\n"
                        + "    AND (\n"
                        + "        CASE \n"
                        + "            WHEN @dateSearch <> '' THEN\n"
                        + "                CASE \n"
                        + "                    WHEN [Date] >= DATEADD(DAY, -7, @dateSearch) AND [Date] <= DATEADD(DAY, 7, @dateSearch) THEN 1\n"
                        + "                    ELSE 0\n"
                        + "                END\n"
                        + "            ELSE 1\n"
                        + "        END\n"
                        + "    ) = 1\n"
                        + ")\n"
                        + "SELECT *\n"
                        + "FROM transactions\n"
                        + "WHERE [rowNumber] BETWEEN @page AND (@page+5);";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, status);
//                Lay trong vong 7 ngay 
                pst.setString(2, date);
                pst.setString(3, (Integer.parseInt(page) - 1) * 5 + "");
                ResultSet table = pst.executeQuery();
                if (table != null)
                {
                    while (table.next())
                    {
                        int tranID = table.getInt("TranID");
                        java.util.Date dateRS = new UtilsFunc().convertStringToBirthDate(table.getString("Date"));
                        int quantity = table.getInt("quantity");
                        double money = table.getDouble("money");
                        String statusRS = (table.getBoolean("Status")) ? "1" : "0";
                        //getPrdObj
                        int prdID = table.getInt("prd_ID");
                        Product prd = new ProductDAO().getProductByID(prdID + "");
                        list.add(new Transaction(tranID, dateRS, quantity, money, statusRS, prd));
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

    public Transaction getTransByID(int id) {
        Transaction trans = null;
        Connection cn = null;
        try
        {
            cn = DBUtils.makeConnection();
            if (cn != null)
            {
                String sql = "SELECT [TranID], [Date], [quantity], [money], [Status], [prd_ID] FROM [dbo].[Transaction_infor]"
                        + "WHERE [TranID] = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, id);
                ResultSet table = st.executeQuery();
                if (table != null)
                {
                    while (table.next())
                    {
                        int tranID = table.getInt("TranID");
                        java.util.Date date = new UtilsFunc().convertStringToBirthDate(table.getString("Date"));
                        double money = table.getDouble("money");
                        int quantity = table.getInt("quantity");
                        String status = (table.getBoolean("Status")) ? "1" : "0";
                        //getPrdObj
                        int prdID = table.getInt("prd_ID");
                        Product prd = new ProductDAO().getProductByID(prdID + "");
                        //end===========================
                        //bug
                        trans = new Transaction(tranID, date, quantity, money, status, prd);

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

    public int updateTransStatus(int id) {
        int result = 0;
        Connection cn = null;
        try
        {
            cn = DBUtils.makeConnection();
            if (cn != null)
            {
                String sql
                        = "UPDATE Transaction_infor\n"
                        + "SET [Status]= ~[Status]\n"
                        + "WHERE [TranID] = ?";

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

    public int updateTransaction(int transID, String date, int quantity, int money, int prdID) {
        int result = 0;
        Connection cn = null;
        try
        {
            cn = DBUtils.makeConnection();
            if (cn != null)
            {
                String sql
                        = "UPDATE [dbo].[Transaction_infor]\n"
                        + "SET [Date]= ?,\n"
                        + "[quantity]= ?,\n"
                        + "[prd_ID] = ?,\n"
                        + "[money]= ?\n"
                        + "WHERE [TranID] = ?";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, date);
                pst.setInt(2, quantity);
                pst.setInt(3, prdID);
                pst.setInt(4, money);
                pst.setInt(5, transID);

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

    public int addNewTransaction(String date, int quantity, int money, int prdID) {
        int result = 0;
        Connection cn = null;
        try
        {
            cn = DBUtils.makeConnection();
            if (cn != null)
            {
                String sql
                        = "INSERT INTO [dbo].[Transaction_infor] ([Date],[quantity],[money],[Status], [prd_ID])\n"
                        + "VALUES (?,?,?,?,?)";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, date);
                pst.setInt(2, quantity);
                pst.setInt(3, money);
                pst.setString(4, "1");
                pst.setInt(5, prdID);

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
