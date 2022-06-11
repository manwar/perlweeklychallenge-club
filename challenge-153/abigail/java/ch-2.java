//
// See https://theweeklychallenge.org/blog/perl-weekly-challenge-153
//

//
// Run as: ln ch-2.java ch2.java; javac ch2.java; java ch2 < input-file
//

import java.util.*;

public class ch2 {
    public static void main (String [] args) {
        Scanner scanner = new Scanner (System . in);
        int [] fac = new int [10];
        fac [0] = 1;
        for (int n = 1; n <= 9; n ++) {
            fac [n] = n * fac [n - 1];
        }
        while (scanner . hasNextInt ()) {
            int num = scanner . nextInt ();
            int sum = 0;
            int n   = num;
            while (n > 0) {
                sum += fac [n % 10];
                n   /= 10;
            }
            System . out . printf ("%d\n", sum == num ? 1 : 0);
        }
    }
}
