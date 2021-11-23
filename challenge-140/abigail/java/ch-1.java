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
        while (scanner . hasNextLine ()) {
            String line = scanner . nextLine ();
            String [] parts = line . trim () . split (" ");
            int a = Integer . parseInt (parts [0], 2);
            int b = Integer . parseInt (parts [1], 2);
            System . out . println (Integer . toBinaryString (a + b));
        }
    }
}
