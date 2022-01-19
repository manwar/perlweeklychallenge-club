//
// See https://theweeklychallenge.org/blog/perl-weekly-challenge-001
//

//
// Run as: ln ch-1.java ch1.java; javac ch1.java; java ch1 < input-file
//

import java.util.*;

public class ch1 {
    public static void main (String [] args) {
        Scanner scanner = new Scanner (System . in);
        while (scanner . hasNextLine ()) {
            String line = scanner . nextLine ();
            int count   = 0;
            int index   = line . indexOf ('e');
            while (index >= 0) {
                count ++;
                index = line . indexOf ('e', index + 1);
            }
            System . out . println (line . replaceAll ("e", "E"));
            System . out . println (count);
        }
    }
}
