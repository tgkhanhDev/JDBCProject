
import java.lang.Math;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author ACER
 */
public class test {

    public static void main(String[] args) {
//
//        HashMap<Product, Integer> cart = new HashMap();
//        Product prd = new Product(1, "abc", "hinh1", "abclam", 12, 13, new ProductCategories(1, "abc1", "", "1"), "1");
//        Product prd2 = new Product(2, "abc2", "hinh1", "abclam", 12, 13, new ProductCategories(1, "abc1", "", "1"), "1");
//        Product prd3 = new Product(3, "abc3", "hinh1", "abclam", 12, 13, new ProductCategories(1, "abc1", "", "1"), "1");
//        Product prd4 = new Product(4, "abc4", "hinh1", "abclam", 12, 13, new ProductCategories(1, "abc1", "", "1"), "1");
//
//        cart.put(prd, 1);
//        cart.put(prd2, 3);
//        cart.put(prd3, 5);
//
//        int total = 0;
//        for (Map.Entry<Product, Integer> entry : cart.entrySet())
//        {
//            total += entry.getValue();
//        }
//
//        System.out.println("check exist: " + cart.containsKey(prd2));
//        
//        System.out.println("Total: "+ total);

        int a = -4;
        int b = 6;
        int c =gcd(a,b);
        ;
        System.out.println("rs: " + c);

    }

    public static int gcd(int a, int b) {
        while (b != 0)
        {
            int temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }
}
