//
// See ../README.md
//

//
// Run as: ln ch-1.java ch1.java; javac ch1.java; java ch1 < input-file
//

import java.util.*;

public class ch1 {
    public static long introot (long square) {
        return ((long) Math . floor (Math . sqrt (square)));
    }

    public static void main (String [] args) {
        Scanner scanner = new Scanner (System . in);
        while (scanner . hasNextInt ()) {
            long n = scanner . nextInt ();
            if (n <= 2) {
                System . out . println ("-1");
                continue;
            }

            long n_sq = n * n;
            long c    = n + 1;
            long c_sq = n_sq + 2 * n + 1;

            while (2 * c - 1 <= n_sq) {
                long b_sq = c_sq - n_sq;
                long b    = introot (b_sq);

                if (b_sq == b * b) {
                    System . out . printf ("%d %d %d\n", n, b, c);
                }

                c_sq += 2 * c + 1;
                c    += 1;
            }

            long max_a = (long) Math . floor (n / Math . sqrt (2));
            long a = 3;
            for (a = 3; a <= max_a; a ++) {
                long b_sq = n_sq - a * a;
                long b    = introot (b_sq);
                if (b_sq == b * b) {
                    System . out . printf ("%d %d %d\n", a, b, n);
                }
            }
        }
    }
}
