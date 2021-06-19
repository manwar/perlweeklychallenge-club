//
// See ../README.md
//

//
// Run as: ln ch-2.java ch2.java; javac ch2.java; java ch2 < input-file
//

import java.util.*;


public class ch2 {
    static void steps (int x, int y, String path) {
        if (x == 0 && y == 0) {
            System . out . println (path);
        }
        if (x > 0) {
            steps (x - 1, y + 1, path + "L");
            steps (x - 1, y,     path + "R");
        }
        if (y > 0) {
            steps (x,     y - 1, path + "H");
        }
    }

    public static void main (String [] args) {
        Scanner scanner = new Scanner (System . in);
        int size = scanner . nextInt ();
        steps (size, 0, "");
    }
}
