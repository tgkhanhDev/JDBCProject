/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

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
public class ServiceDAO {

    //dtb function
    public Service getServiceByID(int id) {
        Service rs = null;
        Connection cn = null;
        try
        {
            cn = DBUtils.makeConnection();
            if (cn != null)
            {
                String sql = "select [SerID], [SerName], [Status] ,[Price] from [dbo].[Service]\n"
                        + "WHERE [SerID] = ?  ";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, id);
                ResultSet table = st.executeQuery();
                if (table != null)
                {
                    while (table.next())
                    {
                        int serID = table.getInt("SerID");
                        String name = table.getString("SerName");
                        String status = (table.getBoolean("Status")) ? "1" : "0";
                        int price = table.getInt("Price");
                        rs = new Service(id, name, status, price);
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

    //==============
    public ArrayList<Service> getAllService() {
        ArrayList<Service> rs = new ArrayList<Service>();
        Connection cn = null;
        try
        {
            cn = DBUtils.makeConnection();
            if (cn != null)
            {
                String sql = "select [SerID], [SerName], [Status] ,[Price] from [dbo].[Service]";
                Statement st = cn.createStatement();
                ResultSet table = st.executeQuery(sql);
                if (table != null)
                {
                    while (table.next())
                    {
                        int id = table.getInt("SerID");
                        String name = table.getString("SerName");
                        String status = (table.getBoolean("Status")) ? "1" : "0";
                        int price = table.getInt("Price");
                        Service ser = new Service(id, name, status, price);
                        rs.add(ser);
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

    public int blockService(String id) {
        int result = 0;
        Connection cn = null;
        try
        {
            cn = DBUtils.makeConnection();
            if (cn != null)
            {
                String sql
                        = "UPDATE [dbo].[Service]\n"
                        + "SET	[Status]= ~[Status]\n"
                        + "WHERE [SerID] = ? ";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, id);

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

    public int updateService(String id, String serName, int price) {
        int result = 0;
        Connection cn = null;
        try
        {
            cn = DBUtils.makeConnection();
            if (cn != null)
            {
                String sql
                        = "UPDATE [dbo].[Service]\n"
                        + "SET	SerName = ?,\n"
                        + "price = ?\n"
                        + "WHERE [SerID] = ? ";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, serName);
                pst.setInt(2, price);
                pst.setString(3, id);

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

    public int addService(String serName, int price) {
        int result = 0;
        Connection cn = null;
        try
        {
            cn = DBUtils.makeConnection();
            if (cn != null)
            {
                String sql
                        = "INSERT INTO [dbo].[Service]([SerName],[Status],[price])\n"
                        + "VALUES(?, 1, ?)"; //9

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, serName);
                pst.setInt(2, price);
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
