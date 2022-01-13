//
// See ../README.md
//

//
// Run as: ln ch-2.java ch2.java; javac ch2.java; java ch2 < input-file
//

import java.util.*;
import java.util.Hashtable;
import java.util.Map;

public class ch2 {
    public static void main (String [] args) {
        Scanner scanner = new Scanner (System . in);
        while (scanner . hasNextLine ()) {
            String line = scanner . nextLine ();

            Map <String, Boolean> palindromes =
                     new Hashtable <String, Boolean> ();

            for (int i = 0; i < line . length (); i ++) {
                for (int j = i; j < line . length (); j ++) {
                    String string = line . substring (i, j + 1);
                    if (string . equals (new StringBuffer (string) .
                                                    reverse () . toString ())) {
                        if (!palindromes . containsKey (string)) {
                            palindromes . put (string, true);
                            System . out . print (string);
                            System . out . print (" ");
                        }
                    }
                }
            }
            System . out . println ("");
        }
    }
}
