//
// See https://theweeklychallenge.org/blog/perl-weekly-challenge-147
//

//
// Run as: ln ch-2.java ch2.java; javac ch2.java; java ch2
//

import java.util.*;

public class ch2 {
    public static void main (String [] args) {
        int p = 0;
        int n = 0;
        Map <Integer, Boolean> pentagon = new Hashtable <Integer, Boolean> ();
        boolean done = false;
        while (true) {
            p += n + n + n + 1;
            n ++;
            pentagon . put (p, true);
            for (Map . Entry <Integer, Boolean> entry: pentagon . entrySet ()) {
                Integer seen = entry . getKey ();
                if (seen + seen < p &&
                    pentagon . containsKey (p - seen) &&
                    pentagon . containsKey (p - seen - seen)) {
                    System . out . printf ("%d %d\n", seen, p - seen);
                    return;
                }
            }
        }
    }
}
