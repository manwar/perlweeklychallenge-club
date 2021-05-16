//
// See ../README.md
//

//
// Run as: ln ch-2.java ch2.java; javac ch2.java; java ch2 < input-file
//

import java.util.Scanner;
import java.lang.Math;


public class ch2 {
    public static void main (String [] args) {
        final double SQRT5 = Math . sqrt (5);
        final double PHI   = (1 + SQRT5) / 2;
        Scanner scanner = new Scanner (System . in);
        while (scanner . hasNextInt ()) {
            System . out . printf ("%d\n",
                (int) Math . round (
                      Math . pow (PHI, scanner . nextInt () + 1) / SQRT5));
        }
    }
}
