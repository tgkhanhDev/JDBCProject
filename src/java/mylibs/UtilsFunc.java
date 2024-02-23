/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mylibs;

import java.util.ArrayList;

/**
 *
 * @author ACER
 */
public class UtilsFunc {

    //Int: mang, so luong item moi trang // out: [ [ ], [ ]  ]
    public ArrayList<ArrayList> pagination(ArrayList arr, int itemPerPage) {
        ArrayList<ArrayList> result = new ArrayList<>();

        //flag
        int track = 0;
        ArrayList index = new ArrayList();

        for (int i = 0; i < arr.size(); i++)
        {
            index.add(arr.get(i));
            track++;

            if (track == itemPerPage)
            {
                result.add(index);
                index = new ArrayList();
                track=0;
            }
        }

        result.add(index);

        return result;
    }
}
