//
// See ../README.md
//

//
// Run as: ln ch-2.java ch2.java; javac ch2.java; java ch2 < input-file
//

import java.util.*;

public class ch2 {
    public static int count (int target, int this_fib, int prev_fib) {
        return target <  this_fib ? 0
             : target == this_fib ? 1
             : count (target - this_fib, this_fib + prev_fib, this_fib) +
               count (target,            this_fib + prev_fib, this_fib);
    }

    public static int count (int target) {
        return count (target, 1, 1);
    }

    public static void main (String [] args) {
        Scanner scanner = new Scanner (System . in);
        while (scanner . hasNextInt ()) {
            System . out . println (count (scanner . nextInt ()));
        }
    }
}
