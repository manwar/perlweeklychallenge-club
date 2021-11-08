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
        int s = 0, c = 0;
        while (scanner . hasNext ()) {
            System . out . println ((s += scanner . nextInt ()) / ++ c);
        }
    }
}
