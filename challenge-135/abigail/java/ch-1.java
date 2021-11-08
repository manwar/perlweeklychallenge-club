//
// See ../README.md
//

//
// Run as: ln ch-1.java ch1.java; javac ch1.java; java ch1 < input-file
//

import java.util.*;
import java.util.regex.Pattern;

public class ch1 {
    public static void main (String [] args) {
        Scanner scanner = new Scanner (System . in);
        try {
            while (true) {
                String line = scanner . nextLine ();
                if (!Pattern . matches ("^[-+]?[0-9]+$", line)) {
                    System . out . println ("not an integer");
                    continue;
                }
                if (Pattern . matches ("^[-+].*", line)) {
                    line = line . substring (1);
                }
                int ll = line . length ();
                if (ll % 2 == 0) {
                    System . out . println ("even number of digits");
                    continue;
                }
                if (ll < 3) {
                    System . out . println ("too short");
                    continue;
                }
                System . out . println (line . substring ((ll - 3) / 2,
                                                          (ll + 3) / 2));
            }
        }
        catch (Exception e) {
            //
            // EOF
            //
        }
    }
}
