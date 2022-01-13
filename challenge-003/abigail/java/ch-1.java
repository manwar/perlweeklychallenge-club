//
// See https://theweeklychallenge.org/blog/perl-weekly-challenge-003
//

//
// Run as: ln ch-1.java ch1.java; javac ch1.java; java ch1 < input-file
//

import java.util.*;

public class ch1 {
    public static void main (String [] args) {
        Scanner scanner = new Scanner (System . in);
        while (scanner . hasNextInt ()) {
            int max = scanner . nextInt ();
            long [] ugly = new long [max];

            ugly [0]   = 1L;
            int count  = 0;
            int next_2 = 0;
            int next_3 = 0;
            int next_5 = 0;

            while (count < max - 1) {
                count ++;
                long min = 0;

                long c2 = 2 * ugly [next_2];
                long c3 = 3 * ugly [next_3];
                long c5 = 5 * ugly [next_5];

                if (c2 <= c3 && c2 <= c5) {min = c2;}
                if (c3 <= c2 && c3 <= c5) {min = c3;}
                if (c5 <= c2 && c5 <= c3) {min = c5;}

                ugly [count] = min;

                if (c2 <= ugly [count]) {next_2 ++;}
                if (c3 <= ugly [count]) {next_3 ++;}
                if (c5 <= ugly [count]) {next_5 ++;}
            }

            System . out . println (ugly [count]);
        }
    }
}
