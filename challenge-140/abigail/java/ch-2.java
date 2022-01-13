//
// See ../README.md
//

//
// Run as: ln ch-2.java ch2.java; javac ch2.java; java ch2 < input-file
//

import java.util.*;

public class ch2 {
    public static void main (String [] args) {
        Scanner scanner = new Scanner (System . in);
        while (scanner . hasNextLong ()) {
            long i = scanner . nextLong ();
            long j = scanner . nextLong ();
            long k = scanner . nextLong ();
            long n = 0;
            while (k > 0) {
                n ++;
                long s = (long) Math . sqrt (n);
                for (long d = 1; d <= s && k > 0; d ++) {
                    if (n % d == 0) {
                        if (d <= i && n / d <= j) {k --;}
                        if (d <= j && n / d <= i) {k --;}
                        if (n == d * d)           {k ++;}
                    }
                }
            }
            System . out . println (n);
        }
    }
}
