//
// See ../README.md
//

//
// Run as: ln ch-2.java ch2.java; javac ch2.java; java ch2 < input-file
//

import java.util.*;
import java.util.regex.Pattern;

public class ch2 {
    public static void main (String [] args) {
        Scanner scanner = new Scanner (System . in);
        String  valid   = "[0-9BCDFGHJKLMNPQRSTVWXYZ]";
        String  pattern = "^" + valid + valid + valid +
                                valid + valid + valid + "[0-9]" + "$";
        int [] w        = {1, 3, 1, 7, 3, 9, 1};
        try {
            while (true) {
                String sedol = scanner . nextLine ();
                //
                // Check for the correct syntax
                //
                if (!Pattern . matches (pattern, sedol)) {
                    System . out . println (0);
                    continue;
                }
                char [] chars = sedol . toCharArray ();
                int check = 0;
                for (int i = 0; i < 7; i ++) {
                    int val = (int) chars [i];
                    val   -= val <= (int) '9' ? (int) '0' : (int) 'A';
                    check += w [i] * val;
                }
                System . out . println (check % 10 == 0 ? 1 : 0);
            }
        }
        catch (Exception e) {
            //
            // EOF
            //
        }
    }
}
