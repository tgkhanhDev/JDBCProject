/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import DTO.Account;
import java.sql.Connection;
import java.util.ArrayList;

/**
 *
 * @author ACER
 */
public class AccountDAO {
    //getaccount:
    public ArrayList<Account> getAllAccount(){
        ArrayList<Account> list= new ArrayList<>();
        Connection cn = null;
        return list;
    }
}
