//
// See ../README.md
//

//
// Run as: ln ch-2.java ch2.java; javac ch2.java; java ch2
//

import java.util.*;

public class ch2 {
    public static final int BASE  = 10;
    public static final int COUNT =  5;

    public static boolean is_long (int number) {
        boolean [] seen = new boolean [number];
        for (int i = 0; i < number; i ++) {
            seen [i] = false;
        }
        int rest = 0;
        for (int i = 2; i <= number; i ++) {
            rest = (rest * BASE + BASE - 1) % number;
            if (seen [rest]) {
                return false;
            }
            seen [rest] = true;
        }
        return true;
    }

    public static void main (String [] args) {
        int number = 1;
        int count  = COUNT;
        while (count > 0) {
            number ++;
            if (BASE % number == 0) {
                continue;
            }
            if (is_long (number)) {
                System . out . println (number);
                count --;
            }
        }
    }
}
