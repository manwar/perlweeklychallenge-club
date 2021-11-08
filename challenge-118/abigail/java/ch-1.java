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
                int    dec = scanner . nextInt ();
                String bin = Integer . toBinaryString (dec);

                if (bin . equals (new StringBuilder (bin) .
                                  reverse () . toString ())) {
                    System . out . println (1);
                }
                else {
                    System . out . println (0);
                }
            }
        }
        catch (Exception e) {
            //
            // EOF
            //
        }
    }
}
