//
// See ../README.md
//

//
// Run as: ln ch-2.java ch2.java; javac ch2.java; java ch2 < input-file
//

import java.util.*;

public class ch2 {
    static int reverse (int num) {
        int rev = 0;
        while (num > 0) {
            rev *= 10;
            rev += num % 10;
            num /= 10;
        }
        return (rev);
    }

    static int ly (int n) {
        return n >= 10000000    ? 1
             : n == reverse (n) ? 0
             : ly (n + reverse (n));
    }

    public static void main (String [] args) {
        Scanner scanner = new Scanner (System . in);
        while (scanner . hasNextInt ()) {
            System . out . println (ly (scanner . nextInt ()));
        }
    }
}
