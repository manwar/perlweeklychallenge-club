//
// See ../README.md
//

//
// Run as: ln ch-2.java ch2.java; javac ch2.java; java ch2 < input-file
//

import java.util.*;


public class ch2 {
    public static void main (String [] args) {
        int DIFF_PER_MINUTE =  11;  // Half degrees
        int MIN_PER_HOUR    =  60;
        int FULL_CIRCLE     = 720;  // Half degrees
        Scanner scanner = new Scanner (System . in);
        try {
            while (true) {
                String line = scanner . nextLine ();
                String [] parts = line . split (":");
                int hours   = Integer . parseInt (parts [0]);
                int minutes = Integer . parseInt (parts [1]);

                int angle = (DIFF_PER_MINUTE *
                            (hours * MIN_PER_HOUR + minutes)) % FULL_CIRCLE;

                if (2 * angle >= FULL_CIRCLE) {
                    angle = FULL_CIRCLE - angle;
                }

                System . out . print (angle / 2);
                if (angle % 2 == 1) {
                    System . out . print (".5");
                }
                System . out . print ("\n");
            }
        }
        catch (Exception e) {
            //
            // EOF
            //
        }
    }
}
