//
// See ../README.md
//

//
// Run as: ln ch-1.java ch1.java; javac ch1.java; java ch1 < input-file
//

import java.util.*;
import java.util.ArrayList;

public class ch1 {
    public static void main (String [] args) {
        Scanner scanner = new Scanner (System . in);
        ArrayList <Integer> numbers = new ArrayList <Integer> ();
        while (scanner . hasNextInt ()) {
            numbers . add (scanner . nextInt ());
        }
        int size = numbers . size () / 2;
        int sum  = 0;
        for (int i = 0; i < size; i ++) {
            sum += numbers . get (i) * numbers . get (size + i);
        }
        System . out . println (sum);
    }
}
