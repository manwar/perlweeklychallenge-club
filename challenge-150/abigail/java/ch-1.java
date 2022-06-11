//
// See https://theweeklychallenge.org/blog/perl-weekly-challenge-150
//

//
// Run as: ln ch-1.java ch1.java; javac ch1.java; java ch1 < input-file
//

import java.util.*;

public class ch1 {
    public static void main (String [] args) {
        Scanner scanner = new Scanner (System . in);
        while (scanner . hasNextLine ()) {
            String line = scanner . nextLine ();
            String [] fibs = line . trim () . split (" ");
            String fib_prev = fibs [0];
            String fib_last = fibs [1];
            while (fib_last . length () < 51) {
                String fib_tmp = fib_last;
                fib_last = fib_prev + fib_last;
                fib_prev = fib_tmp;
            }
            System . out . println (fib_last . substring (50, 51));
        }
    }
}
