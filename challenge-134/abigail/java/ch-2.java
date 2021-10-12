//
// See ../README.md
//

//
// Run as: ln ch-2.java ch2.java; javac ch2.java; java ch2 < input-file
//

import java.util.*;
import java.util.Hashtable;
import java.util.Map;

public class ch2 {
    public static void main (String [] args) {
        Scanner scanner = new Scanner (System . in);
        try {
            while (true) {
                int n = scanner . nextInt ();
                int m = scanner . nextInt ();

                Map <Integer, Integer> seen =
                     new Hashtable <Integer, Integer> ();

                for (int i = 1; i <= n; i ++) {
                    for (int j = 1; j <= m; j ++) {
                        seen . put (i * j, 1);
                    }
                }
                System . out . println (seen . size ());
            }
        }
        catch (Exception e) {
            //
            // EOF
            //
        }
    }
}
