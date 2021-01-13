// # Perl Weekly Challenge #075 Task 1 Coins Sum, Java Program
// task statement: 
// You are given a set of coins @C, assuming you have 
// infinite amount of each coin in the set.
// Write a script to find how many ways you make 
// sum $S using the coins from the set @C.

import java.util.Scanner;
import java.util.ArrayList;
import java.util.Vector;
import java.util.Collections;
import java.util.Arrays;

public class coinssum {
    static public void main(String[] args) {
        // int[] coins = new int[] {1, 2, 4};
        // int total = 5;

        Scanner scn = new Scanner(System.in);
        System.out.println("Input expected sum of coins:");
        int total = scn.nextInt();
        System.out.println("Input number of varieties of coins:");
        int size = scn.nextInt();
        int[] coins = new int[size];
        System.out.println("Input values of the coins:");
        for (int k = 0; k < size; k++) {
            coins[k] = scn.nextInt();
        }


// initialize the "ArrayList" for dynamic programming
        ArrayList<Vector>[] arr_for_dp = new ArrayList[total+1];

        int j = 0;
        for (int i=0; i <= total; i++) {
            arr_for_dp[i] = new ArrayList<Vector>();
            if (i == coins[j]) {
                Vector temp = new Vector();
                temp.addElement(new Integer(coins[j]));
                arr_for_dp[i].add( temp );
                if (j < coins.length-1) {
                    j++;
                }
            }
        }

        for (int i=0; i<=total; i++) {
            for (int k=0; k < coins.length; k++) {
                if (i-coins[k] > 0) {
                     for (int p=0; p < arr_for_dp[i-coins[k]].size(); p++) {
                          Vector partition = arr_for_dp[i-coins[k]].get(p);
                          Vector partition_p = new Vector<Integer>();
                          partition_p = (Vector)partition.clone();
                          partition_p.addElement(coins[k]);
                          Collections.sort(partition_p);
                          if ((!arr_for_dp[i].contains(partition_p))) {
                              arr_for_dp[i].add(partition_p);
                          }
                      
                      }
                }
            }
        }


        int ans = arr_for_dp[total].size();
        if ( ans > 0) {
            for (int f=0; f<ans; f++) {
                Vector testvector = arr_for_dp[total].get(f);
                System.out.println(testvector);
            }
        }
        

        System.out.println(ans);

    }

    
    
    
}



//references:
//textbook
//https://www.w3schools.com/java/java_arraylist.asp
//https://www.geeksforgeeks.org/array-of-arraylist-in-java/
//https://www.cis.upenn.edu/~bcpierce/courses/629/jdkdocs/api/java.util.Vector.html
