//
// See ../README.md
//

//
// Run as: ln ch-1.java ch1.java; javac ch1.java; java ch1 < input-file
//

import java.util.*;

public class ch1 {
    public static void main (String [] args) {
        Scanner scanner = new Scanner (System . in);
        try {
            while (true) {
                int m = scanner . nextInt ();
                int n = scanner . nextInt ();
                System . out . println (m ^ (1 << (n - 1)));
            }
        }
        catch (Exception e) {
            //
            // EOF
            //
        }
    }
}
