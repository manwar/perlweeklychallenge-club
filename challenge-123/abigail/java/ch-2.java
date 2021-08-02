//
// See ../README.md
//

//
// Run as: ln ch-2.java ch2.java; javac ch2.java; java ch2 < input-file
//

import java.util.*;

public class ch2 {
    static int dist (int x1, int y1, int x2, int y2) {
        return (x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2);
    }
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

            System . out . println (
                dist (x1, y1, x2, y2) == dist (x2, y2, x3, y3) &&
                dist (x2, y2, x3, y3) == dist (x3, y3, x4, y4) &&
                dist (x3, y3, x4, y4) == dist (x4, y4, x1, y1) &&
                dist (x1, y1, x3, y3) == dist (x2, y2, x4, y4) ? 1 : 0);
        }
    }
}
