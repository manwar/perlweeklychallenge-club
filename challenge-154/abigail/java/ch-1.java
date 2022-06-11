//
// See https://theweeklychallenge.org/blog/perl-weekly-challenge-154
//

//
// Run as: ln ch-1.java ch1.java; javac ch1.java; java ch1 < input-file
//

import java.util.*;

public class ch1 {
    public static void main (String [] args) {
        String [] p = {"PERL", "PELR", "PREL", "PRLE", "PLER", "PLRE",
                       "EPRL", "EPLR", "ERPL", "ERLP", "ELPR", "ELRP",
                       "REPL", "RELP", "RPEL", "RPLE", "RLEP", "RLPE",
                       "LERP", "LEPR", "LREP", "LRPE", "LPER", "LPRE"};

        Scanner scanner = new Scanner (System . in);
        while (scanner . hasNextLine ()) {
            String line = scanner . nextLine () . trim ();
            for (int i = 0; i < 24; i ++) {
                if (p [i] . equals (line)) {
                    p [i] = "";
                }
            }
        }
        for (int i = 0; i < 24; i ++) {
            if (p [i] != "") {
                System . out . println (p [i]);
            }
        }
    }
}
