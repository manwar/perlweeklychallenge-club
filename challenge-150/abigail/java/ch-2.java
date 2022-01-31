//
// See https://theweeklychallenge.org/blog/perl-weekly-challenge-150
//

//
// Run as: ln ch-2.java ch2.java; javac ch2.java; java ch2
//

import java.util.*;

public class ch2 {
    public static void main (String [] args) {
        int [] primes = {2, 3, 5, 7, 11, 13, 17, 19};
        for (int n = 1; n <= 500; n ++) {
            boolean has_square = false;
            for (int p: primes) {
                if (n % (p * p) == 0) {
                    has_square = true;
                    break;
                }
            }
            if (!has_square) {
                System . out . printf ("%d ", n);
            }
        }
        System . out . printf ("\n");
    }
}
