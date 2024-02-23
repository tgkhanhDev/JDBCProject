
import java.util.ArrayList;

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

    public static ArrayList<ArrayList> pagination(ArrayList arr, int itemPerPage) {
        ArrayList<ArrayList> result = new ArrayList<>();

        //flag
        int track = 0;
        ArrayList index = new ArrayList();

        for (int i = 0; i < arr.size(); i++)
        {
            index.add(arr.get(i));
            track++;

            
            if(track == itemPerPage){
                result.add(index);
                index = new ArrayList();
                track = 0;
            }
        }

        result.add(index);

        return result;
    }

    public static void main(String[] args) {
        ArrayList arr = new ArrayList();
        arr.add("MOT");
        arr.add("HAI");
        arr.add("BA");
        arr.add("BON");
        arr.add("NAM");
        arr.add("SAU");
        arr.add("BAY");
        arr.add("TAM");
        ArrayList<ArrayList> list = pagination(arr, 5);
        ArrayList currList = list.get(1);
        for (Object obj : currList)
        {
            System.out.println(obj);
            
        }

    }

}
