//
// See ../README.md
//

//
// Run as: ln ch-1.java ch1.java; javac ch1.java; java ch1 < input-file
//

import java.util.*;

public class ch1 {
    public static void main (String [] args) {
        int count          = 10;
        int nr_of_divisors =  8;
        for (int n = 1; count > 0; n ++) {
            int s = (int) Math . sqrt (n);
            if (n == s * s) {
                continue;
            }
            int c = 0;
            for (int d = 1; d <= s && c <= nr_of_divisors; d ++) {
                if (n % d == 0) {
                    c += 2;
                }
            }
            if (c == nr_of_divisors) {
                System . out . println (n);
                count --;
            }
        }
    }
}
