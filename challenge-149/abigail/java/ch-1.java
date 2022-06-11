//
// See https://theweeklychallenge.org/blog/perl-weekly-challenge-149
//

//
// Run as: ln ch-1.java ch1.java; javac ch1.java; java ch1 < input-file
//

import java.util.*;
import java.util.Map;

public class ch1 {
    private static int digit_sum (int n) {
        int sum  =  0;
        int base = 10;
        while (n > 0) {
            sum += n % base;
            n    = (int) Math . floor (n / base);
        }
        return (sum);
    }

    private static int fib_prev = 0;
    private static int fib_last = 1;
    private static Map <Integer, Boolean> fib =
         new Hashtable <Integer, Boolean> ();

    private static void fib_init () {
        fib . put (fib_prev, true);
        fib . put (fib_last, true);
    }

    private static boolean is_fib (int n) { 
        while (fib_last < n) {
            int t     = fib_last;
            fib_last += fib_prev;
            fib_prev  = t;
            fib . put (fib_last, true);
        }
        return (fib . containsKey (n));
    }


    public static void main (String [] args) {
        fib_init ();
        Scanner scanner = new Scanner (System . in);
        while (scanner . hasNextInt ()) {
            int n = scanner . nextInt ();
            for (int k = 0; n > 0; k ++) {
                if (is_fib (digit_sum (k))) {
                    System . out . printf ("%d ", k);
                    n --;
                }
            }
            System . out . printf ("\n");
        }
    }
}
