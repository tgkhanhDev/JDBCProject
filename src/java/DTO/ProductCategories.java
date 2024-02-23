/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DTO;

/**
 *
 * @author ACER
 */
public class ProductCategories {

    private String cate_ID;
    private String name;
    private String icon;

    public ProductCategories() {
    }

    public ProductCategories(String cate_ID, String name, String icon) {
        this.cate_ID = cate_ID;
        this.name = name;
        this.icon = icon;
    }

    public String getCate_ID() {
        return cate_ID;
    }

    public void setCate_ID(String cate_ID) {
        this.cate_ID = cate_ID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }
    
    

}
