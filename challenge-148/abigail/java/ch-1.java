//
// See https://theweeklychallenge.org/blog/perl-weekly-challenge-148
//

//
// Run as: ln ch-1.java ch1.java; javac ch1.java; java ch1
//

import java.util.*;

public class ch1 {
    public static void main (String [] args) {
        for (int i = 0; i <= 100; i ++) {
            int u = i % 10;
            int t = i / 10;
            if (!(i == 0 || t == 1 || u == 1 || t == 7 || u == 7 
                         || t == 8 || u == 8 || t == 9 || u == 9
                         || t == 2 || u == 3 || u == 5 || i == 100)) {
                System . out . printf ("%d ", i);
            }
        }
        System . out . printf ("\n");
    }
}
