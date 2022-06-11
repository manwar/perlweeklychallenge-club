//
// See https://theweeklychallenge.org/blog/perl-weekly-challenge-151
//

//
// Run as: ln ch-2.java ch2.java; javac ch2.java; java ch2 < input-file
//

import java.util.*;

public class ch2 {
    public static void main (String [] args) {
        Scanner scanner = new Scanner (System . in);
        while (scanner . hasNextLine ()) {
            String line = scanner . nextLine ();
            Scanner inner_scanner = new Scanner (line);
            ArrayList <Integer> h = new ArrayList <Integer> ();
            while (inner_scanner . hasNextInt ()) {
                h . add (inner_scanner . nextInt ());
            }
            h . add (0);
            h . add (0);
            for (int i = h . size () - 3; i >= 2; i --) {
                h . set (i, Math . max (h . get (i) + h . get (i + 2),
                                        h . get (i + 1)));
            }
            System . out . printf ("%d\n", h . get (0) + h . get (2));
        }
    }
}
