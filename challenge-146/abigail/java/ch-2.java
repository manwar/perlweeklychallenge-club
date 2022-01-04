//
// See ../README.md
//

//
// Run as: ln ch-2.java ch2.java; javac ch2.java; java ch2 < input-file
//

import java.util.*;

public class ch2 {
    public static void main (String [] args) {
        Scanner scanner = new Scanner (System . in);
        while (scanner . hasNextLine ()) {
            String [] parts = scanner . nextLine () . trim () . split ("/");
            int a = Integer . parseInt (parts [0]);
            int b = Integer . parseInt (parts [1]);
            for (int i = 1; i <= 2; i ++) {
                if (a < b) {
                    b -= a;
                }
                else {
                    a -= b;
                }
                if (a == 0 || b == 0) {
                    break;
                }
                System . out . printf ("%d/%d ", a, b);
            }
            System . out . printf ("\n");
        }
    }
}
