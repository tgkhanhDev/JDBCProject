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
public class Product {
    private int prd_ID;
    private String name;
    private String thumbnail;
    private String description;
    private int price;
    private int speed;
    private int cate_ID;

    public Product() {
    }

    public Product(int prd_ID, String name, String thumbnail, String description, int price, int speed, int cate_ID) {
        this.prd_ID = prd_ID;
        this.name = name;
        this.thumbnail = thumbnail;
        this.description = description;
        this.price = price;
        this.speed = speed;
        this.cate_ID = cate_ID;
    }

    public int getPrd_ID() {
        return prd_ID;
    }

    public void setPrd_ID(int prd_ID) {
        this.prd_ID = prd_ID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getThumbnail() {
        return thumbnail;
    }

    public void setThumbnail(String thumbnail) {
        this.thumbnail = thumbnail;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public int getSpeed() {
        return speed;
    }

    public void setSpeed(int speed) {
        this.speed = speed;
    }

    public int getCate_ID() {
        return cate_ID;
    }

    public void setCate_ID(int cate_ID) {
        this.cate_ID = cate_ID;
    }
}
