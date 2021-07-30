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
        while (scanner . hasNext ()) {
            int x1 = scanner . nextInt ();
            int y1 = scanner . nextInt ();
            int x2 = scanner . nextInt ();
            int y2 = scanner . nextInt ();
            int x3 = scanner . nextInt ();
            int y3 = scanner . nextInt ();
            int x4 = scanner . nextInt ();
            int y4 = scanner . nextInt ();

            int e1 = (x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2);
            int e2 = (x2 - x3) * (x2 - x3) + (y2 - y3) * (y2 - y3);
            int e3 = (x3 - x4) * (x3 - x4) + (y3 - y4) * (y3 - y4);
            int e4 = (x4 - x1) * (x4 - x1) + (y4 - y1) * (y4 - y1);
            int d1 = (x1 - x3) * (x1 - x3) + (y1 - y3) * (y1 - y3);
            int d2 = (x2 - x4) * (x2 - x4) + (y2 - y4) * (y2 - y4);

            System . out . println (e1 == e2 && e2 == e3 &&
                                    e3 == e4 && d1 == d2 ? 1 : 0);
        }
    }
}
