//
// See https://theweeklychallenge.org/blog/perl-weekly-challenge-002
//

//
// Run as: ln ch-2.java ch2.java; javac ch2.java; java ch2 < input-file
//

import java.util.*;

public class ch2 {
    public static void main (String [] args) {
        Boolean from_base = false;
        Boolean to_base   = false;

        if (args . length == 1) {
            if (args [0] . equals ("-f")) {
                from_base = true;
            }
            if (args [0] . equals ("-t")) {
                to_base   = true;
            }
        }

        Scanner scanner = new Scanner (System . in);
        while (scanner . hasNextLine ()) {
            String line = scanner . nextLine () . trim ();
            if (from_base) {
                System . out . println (Integer . parseInt (line, 35));
            }
            if (to_base) {
                System . out . println (Integer . toString (
                                        Integer . parseInt (line), 35) .
                                                  toUpperCase ());
            }
        }
    }
}
