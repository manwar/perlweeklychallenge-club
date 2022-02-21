//
// See https://theweeklychallenge.org/blog/perl-weekly-challenge-153
//

//
// Run as: ln ch-1.java ch1.java; javac ch1.java; java ch1
//

import java.util.*;

public class ch1 {
    public static void main (String [] args) {
        int sum = 1;
        int fac = 1;
        System . out . printf ("%d", sum);
        for (int n = 1; n <= 9; n ++) {
            fac *= n;
            sum += fac;
            System . out . printf (" %d", sum);
        }
        System . out . printf ("\n");
    }
}
