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
        while (scanner . hasNextInt ()) {
            System . out . printf ("%.0f\n",
                Math . exp (
                    Math . log (scanner . nextInt ()) / 2
                )
            );
        }
    }
}
