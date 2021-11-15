//
// See ../README.md
//

//
// Run as: ln ch-2.java ch2.java; javac ch2.java; java ch2 < input-file
//

import java.util.*;
import java.lang.*;

public class ch2 {
    public static boolean can_split (long target, long number) {
        if (target >  number || target < 0) {return false;}
        if (target == number)               {return true;}

        long pow_10 = 10;

        while (pow_10 <= number) {
            if (can_split (target - (number % pow_10), number / pow_10)) {
                return true;
            }
            pow_10 *= 10;
        }

        return false;
    }

    public static void main (String [] args) {
        Scanner scanner = new Scanner (System . in);
        while (scanner . hasNextInt ()) {
            int number = scanner . nextInt ();
            int sqrt   = (int) Math . round (Math . sqrt (number));
            if (number > 1 && can_split (sqrt, number)) {
                System . out . println (1);
            }
            else {
                System . out . println (0);
            }
        }
    }
}
