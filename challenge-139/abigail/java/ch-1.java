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
            String [] list = line . split (" ");
            boolean sorted = true;
            for (int i = 1; sorted && i < list . length; i ++) {
                sorted = Integer . parseInt (list [i - 1]) <=
                         Integer . parseInt (list [i]);
            }
            System . out . println (sorted ? 1 : 0);
        }
    }
}
