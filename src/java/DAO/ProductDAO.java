/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import DTO.Product;
import DTO.ProductCategories;
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
public class ProductDAO {

    //Lấy toàn bộ category bên product
    public ArrayList<ProductCategories> getAllCategories() {
         ArrayList<ProductCategories> list = new ArrayList<>();

        Connection cn = null;
        try
        {
            cn = DBUtils.makeConnection();
            if (cn != null)
            {
                String sql = "SELECT [cate_ID], [Name], [Icon] FROM [dbo].[Category]";

                Statement st = cn.createStatement();
                ResultSet table = st.executeQuery(sql);

                if (table != null)
                {
                    while (table.next())
                    {
                        String cate_ID= table.getString("cate_ID");
                        String name = table.getString("Name");
                        String icon= table.getString("Icon");
                        list.add(new ProductCategories(cate_ID, name, icon));
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

    public ArrayList<Product> getAllProductByCateID(String cate_ID) {
        ArrayList<Product> list = new ArrayList<>();

        Connection cn = null;
        try
        {
            cn = DBUtils.makeConnection();
            if (cn != null)
            {
                String sql = "SELECT [prd_ID],[name],[thumnail], [description],[price],[speed],[cate_ID] from [dbo].[Product]\n"
                        + "WHERE [cate_ID] like ?";

                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, cate_ID);
                ResultSet table = st.executeQuery();

                if (table != null)
                {
                    while (table.next())
                    {
                        int id = table.getInt("prd_ID");
                        String name = table.getString("name");
                        String thumbnail = table.getString("thumnail");
                        String description = table.getString("description");
                        int price = table.getInt("price");
                        int speed = table.getInt("speed");
                        int cateid = table.getInt("cate_ID");

                        Product prd = new Product(id, name, thumbnail, description, price, speed, cateid);
                        list.add(prd);
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
