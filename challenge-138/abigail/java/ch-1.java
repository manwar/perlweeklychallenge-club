//
// See ../README.md
//

//
// Run as: ln ch-1.java ch1.java; javac ch1.java; java ch1 < input-file
//

import java.util.*;

public class ch1 {
    static int [] [] lookup = {
        {261, 260, 260, 261, 261, 261, 261},
        {262, 261, 260, 261, 262, 262, 262},
    };

    public static final int SUNDAY    = 0;
    public static final int MONDAY    = 1;
    public static final int TUESDAY   = 2;
    public static final int WEDNESDAY = 3;
    public static final int THURSDAY  = 4;
    public static final int FRIDAY    = 5;
    public static final int SATURDAY  = 6;

    static int [] anchors = {TUESDAY, SUNDAY, FRIDAY, WEDNESDAY};

    public static int doomsday (int year) {
        int anchor = anchors [(year / 100) % 4];
        int y      = year % 100;
        return (((y / 12) + (y % 12) + ((y % 12) / 4)) + anchor) % 7;
    }

    public static int is_leap (int year) {
        if ((year % 400 == 0) || (year % 4 == 0) && (year % 100 != 0)) {
            return 1;
        }
        return 0;
    }

    public static void main (String [] args) {
        Scanner scanner = new Scanner (System . in);
        while (scanner . hasNextInt ()) {
            int year = scanner . nextInt ();
            System . out . println (lookup [is_leap (year)] [doomsday (year)]);
        }
    }
}
