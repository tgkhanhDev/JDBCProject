/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import DTO.Account;
import DTO.Role;
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
public class AccountDAO {

    //dtb query function
    public Role getRoleByID(int id) {
        Role rs = null;
        Connection cn = null;
        try
        {
            cn = DBUtils.makeConnection();
            if (cn != null)
            {
                String sql = "SELECT [RoleID], [RoleName]  FROM [dbo].[Role]\n"
                        + "WHERE [RoleID] = ?  ";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, id);
                ResultSet table = st.executeQuery();
                if (table != null)
                {
                    while (table.next())
                    {
                        int roleid = table.getInt("RoleID");
                        String roleName = table.getString("RoleName");
                        rs = new Role(roleid, roleName);
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

    //getaccount:
    public ArrayList<Account> getAllAccount() {
        ArrayList<Account> list = new ArrayList<>();
        Connection cn = null;
        try
        {
            cn = DBUtils.makeConnection();
            if (cn != null)
            {
                String sql = "SELECT [AccountID],[LastName],[FirstName], [Phone],[Gmail],[Password],[status], [PolicyStatus],[dbo].[Role].[RoleID],[Script] FROM [dbo].[Account]\n"
                        + "JOIN [dbo].[Role] ON [dbo].[Account].[RoleID] = [dbo].[Role].RoleID";
                Statement st = cn.createStatement();
                ResultSet table = st.executeQuery(sql);
                if (table != null)
                {
                    while (table.next())
                    {
                        int id = table.getInt("AccountID");
                        String lastName = table.getString("LastName");
                        String firstName = table.getString("FirstName");
                        String phone = table.getString("Phone");
                        String gmail = table.getString("Gmail");
                        String password = table.getString("Password");
                        String status = (table.getBoolean("status")) ? "1" : "0";
                        String policyStatus = (table.getBoolean("PolicyStatus")) ? "1" : "0";
                        //Get ROLE
                        int roleid = table.getInt("RoleID");
                        Role role = getRoleByID(roleid);
                        //=======
                        String script = table.getString("Script");
                        list.add(new Account(id, lastName, firstName, phone, gmail, password, status, policyStatus, role, script));
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

    public ArrayList<Account> getAccountByPhone(String phoneParam) {
        ArrayList<Account> list = new ArrayList<>();
        Connection cn = null;
        try
        {
            cn = DBUtils.makeConnection();
            if (cn != null)
            {
                String sql = "SELECT [AccountID],[LastName],[FirstName], [Phone],[Gmail],[Password],[status], [PolicyStatus],[dbo].[Role].[RoleID],[Script] FROM [dbo].[Account]\n"
                        + "JOIN [dbo].[Role] ON [dbo].[Account].[RoleID] = [dbo].[Role].RoleID\n"
                        + "WHERE [dbo].[Account].[Phone] like ?  ";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, "%" + phoneParam + "%");
                ResultSet table = st.executeQuery();
                if (table != null)
                {
                    while (table.next())
                    {
                        int id = table.getInt("AccountID");
                        String lastName = table.getString("LastName");
                        String firstName = table.getString("FirstName");
                        String phone = table.getString("Phone");
                        String gmail = table.getString("Gmail");
                        String password = table.getString("Password");
                        String status = (table.getBoolean("status")) ? "1" : "0";
                        String policyStatus = (table.getBoolean("PolicyStatus")) ? "1" : "0";
                        //Get ROLE
                        int roleid = table.getInt("RoleID");
                        Role role = getRoleByID(roleid);
                        //=======
                        String script = table.getString("Script");
                        list.add(new Account(id, lastName, firstName, phone, gmail, password, status, policyStatus, role, script));
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

    public Account getAccountByID(String idParam) {
        Account list = new Account();
        Connection cn = null;
        try
        {
            cn = DBUtils.makeConnection();
            if (cn != null)
            {
                String sql = "SELECT [AccountID],[LastName],[FirstName], [Phone],[Gmail],[Password],[status], [PolicyStatus],[dbo].[Role].[RoleID],[Script] FROM [dbo].[Account]\n"
                        + "JOIN [dbo].[Role] ON [dbo].[Account].[RoleID] = [dbo].[Role].RoleID\n"
                        + "WHERE [dbo].[Account].[AccountID] = ? ";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, idParam);
                ResultSet table = st.executeQuery();
                if (table != null)
                {
                    while (table.next())
                    {
                        int id = table.getInt("AccountID");
                        String lastName = table.getString("LastName");
                        String firstName = table.getString("FirstName");
                        String phone = table.getString("Phone");
                        String gmail = table.getString("Gmail");
                        String password = table.getString("Password");
                        String status = (table.getBoolean("status")) ? "1" : "0";
                        String policyStatus = (table.getBoolean("PolicyStatus")) ? "1" : "0";
                        //Get ROLE
                        int roleid = table.getInt("RoleID");
                        Role role = getRoleByID(roleid);
                        //=======
                        String script = table.getString("Script");
                        list = (new Account(id, lastName, firstName, phone, gmail, password, status, policyStatus, role, script));
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

    public ArrayList<Role> getAllAccountRole() {
        ArrayList<Role> list = new ArrayList<>();
        Connection cn = null;
        try
        {
            cn = DBUtils.makeConnection();
            if (cn != null)
            {
                String sql = "SELECT [RoleID],[RoleName] FROM [dbo].[Role]";
                Statement st = cn.createStatement();
                ResultSet table = st.executeQuery(sql);
                if (table != null)
                {
                    while (table.next())
                    {
                        int id = table.getInt("RoleID");
                        String roleName = table.getString("RoleName");
                        list.add(new Role(id, roleName));
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

    //POST UPDATE
    public int updateAccountInfo(Account acc) {
        int result = 0;
        Connection cn = null;
        try
        {
            cn = DBUtils.makeConnection();
            if (cn != null)
            {
                String sql
                        = "UPDATE [dbo].[Account]\n"
                        + "SET \n"
                        + "[LastName]=?,\n"
                        + "[FirstName]=?,\n"
                        + "[Phone]=?,\n"
                        + "[Gmail]=?,\n"
                        + "[Password]=?,\n"
                        + "[status]=?,\n"
                        + "[PolicyStatus]=?,\n"
                        + "[RoleID]=(SELECT [dbo].[Role].[RoleID] FROM [dbo].[Role]\n"
                        + "                Where [dbo].[Role].RoleName =?  ),\n"
                        + "[Script]=?\n"
                        + "WHERE [AccountID] = ?";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, acc.getLastName());
                pst.setString(2, acc.getFirstName());
                pst.setString(3, acc.getPhone());
                pst.setString(4, acc.getGmail());
                pst.setString(5, acc.getPassword());
                pst.setString(6, acc.getStatus());
                pst.setString(7, acc.getPolicyStatus());
                pst.setString(8, acc.getRole().getRoleName());
                pst.setString(9, acc.getScript());
                pst.setInt(10, acc.getAccountID());

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

    public int AddAccount(Account acc) {
        int result = 0;
        Connection cn = null;
        try
        {
            cn = DBUtils.makeConnection();
            if (cn != null)
            {
                String sql
                        = "INSERT INTO [dbo].[Account] ([LastName],[FirstName],[Phone],[Gmail],[Password],[status],[PolicyStatus],[RoleID],[Script])\n"
                        + "VALUES ("
                        + "?" //1
                        + ",?" //2
                        + ",?"//3
                        + ",?"//4
                        + ",?"//5
                        + ",?"//6
                        + ",?"//7
                        + ",(SELECT [dbo].[Role].[RoleID] FROM [dbo].[Role]\n"
                        + "Where [dbo].[Role].RoleName = ? )" //8
                        + ",?)"; //9

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, acc.getLastName());
                pst.setString(2, acc.getFirstName());
                pst.setString(3, acc.getPhone());
                pst.setString(4, acc.getGmail());
                pst.setString(5, acc.getPassword());
                pst.setString(6, acc.getStatus());
                pst.setString(7, acc.getPolicyStatus());
                pst.setString(8, acc.getRole().getRoleName());
                pst.setString(9, acc.getScript());

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

    public int blockAccount(String id) {
        int result = 0;
        Connection cn = null;
        try
        {
            cn = DBUtils.makeConnection();
            if (cn != null)
            {
                String sql
                        = "UPDATE [dbo].[Account]\n"
                        + "SET [dbo].[Account].[status]= ~[dbo].[Account].[status]\n"
                        + "WHERE [dbo].[Account].[AccountID]= ?";

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

    public int blockAccount_Policy(String id) {
        int result = 0;
        Connection cn = null;
        try
        {
            cn = DBUtils.makeConnection();
            if (cn != null)
            {
                String sql
                        = "UPDATE [dbo].[Account]\n"
                        + "SET [dbo].[Account].[PolicyStatus]= ~[dbo].[Account].[PolicyStatus]\n"
                        + "WHERE [dbo].[Account].[AccountID]= ?";

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

}
