//
// See ../README.md
//

//
// Run as: ln ch-2.java ch2.java; javac ch2.java; java ch2 < input-file
//

import java.util.*;

public class ch2 {
    public static int substrings (String n, int m, int prefix, int max) {
        if (n . length () == 0) {
            return prefix > -1   &&
                   prefix < max  &&
                   prefix % m == 0 ? 1 : 0;
        }

        int fc       = Integer . parseInt (n . substring (0, 1));
        int n_prefix = 10 * (prefix == -1 ? 0 : prefix) + fc;
        String tail  = n . substring (1, n. length ());

        return substrings (tail, m, n_prefix, max) +
               substrings (tail, m,   prefix, max);
    }


    public static void main (String [] args) {
        Scanner scanner = new Scanner (System . in);
        while (scanner . hasNextInt ()) {
            int n = scanner . nextInt ();
            int m = scanner . nextInt ();
            System . out . println (
                substrings (Integer . toString (n), m, -1, n));
        }
    }
}
