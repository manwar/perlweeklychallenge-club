//
// See ../README.md
//

//
// Run as: ln ch-1.java ch1.java; javac ch1.java; java ch1 < input-file
//

import java.util.*;

public class ch1 {
    //
    // Find the GCD, using Stein's algorithm
    //    (https://en.wikipedia.org/wiki/Binary_GCD_algorithm)
    //
    public static int gcd (int u, int v) {
        boolean u_odd = u % 2 != 0;
        boolean v_odd = v % 2 != 0;

        return u == v || v == 0 ? u
             :           u == 0 ? v
             : !u_odd && !v_odd ? gcd (u >> 1, v >> 1) << 1
             : !u_odd &&  v_odd ? gcd (u >> 1, v)
             :  u_odd && !v_odd ? gcd (u,      v >> 1)
             :  u     >   v     ? gcd (u - v, v)
             :                    gcd (v - u, u);
    }

    //
    // Return true if number is a power of n, that is, number == n ^ p
    // for some non-negative integer p. Return false otherwise.
    //
    public static boolean is_power_of_n (int number, int n) {
        return number <  1     ? false
             : number == 1     ? true
             : number % n != 0 ? false
             : is_power_of_n (number / n, n);
    }

    public static boolean is_power_of_2 (int number) {
        return is_power_of_n (number, 2);
    }

    public static void main (String [] args) {
        Scanner scanner = new Scanner (System . in);
        while (scanner . hasNextInt ()) {
            int n = scanner . nextInt ();
            int m = scanner . nextInt ();

            int r = gcd (n, m);

            System . out . println (r > 1 && is_power_of_2 (r) ? 1 : 0);
        }
    }
}
