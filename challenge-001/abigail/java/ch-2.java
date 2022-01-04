//
// See https://theweeklychallenge.org/blog/perl-weekly-challenge-001
//

//
// Run as: ln ch-2.java ch2.java; javac ch2.java; java ch2 < input-file
//

import java.util.*;

public class ch2 {
    public static void main (String [] args) {
        Scanner scanner = new Scanner (System . in);
        while (scanner . hasNextInt ()) {
            int max = scanner . nextInt ();
            for (int i = 1; i <= max; i ++) {
                System . out . println (i % 15 == 0 ? "fizzbuzz"
                                      : i %  5 == 0 ?     "buzz"
                                      : i %  3 == 0 ? "fizz"
                                      :                i);
            }
        }
    }
}
