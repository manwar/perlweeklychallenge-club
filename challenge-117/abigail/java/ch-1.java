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
        int sum    = 0;
        int SUM_15 = 120;
        try {
            while (true) {
                String line = scanner . nextLine ();
                //
                // Googling suggest Java has a gazillion methods to
                // convert string to integers -- and they all crap
                // out if the string starts with a number, and has
                // anything trailing. None of them actually similate atoi.
                // 
                // So, handrolling it is!
                //
                int i, n = 0;
                for (i = 0; i < line . length (); i ++) {
                    if (line . charAt (i) < "0" . charAt (0) ||
                        line . charAt (i) > "9" . charAt (0)) {
                        break;
                    }
                    n *= 10;
                    n += line . charAt (i) - "0" . charAt (0);
                }
                sum += n;
            }
        }
        catch (Exception e) {
            System . out . println (SUM_15 - sum);
        }
    }
}
