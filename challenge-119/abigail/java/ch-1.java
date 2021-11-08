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
        try {
            while (true) {
                int num = scanner . nextInt ();
                System . out . println ( (num & ~0xFF)
                                       | (num &  0x0F) << 4
                                       | (num &  0xF0) >> 4);
            }
        }
        catch (Exception e) {
            //
            // EOF
            //
        }
    }
}
