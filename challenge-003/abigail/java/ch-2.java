//
// See https://theweeklychallenge.org/blog/perl-weekly-challenge-003
//

//
// Run as: ln ch-2.java ch2.java; javac ch2.java; java ch2 < input-file
//

import java.util.*;

public class ch2 {
    public static void main (String [] args) {
        Scanner scanner = new Scanner (System . in);
        while (scanner . hasNextInt ()) {
            int max = scanner . nextInt ();
            int [] current_row = new int [1];
            current_row [0] = 1;
            System . out . println ("1");

            for (int row = 1; row <= max; row ++) {
                int [] next_row = new int [row + 1];
                next_row [0]   = 1;
                next_row [row] = 1;
                System . out . print ("1 ");
                for (int col = 1; col < row; col ++) {
                    next_row [col] = current_row [col - 1] + current_row [col];
                    System . out . printf ("%d ", next_row [col]);
                }
                System . out . println ("1");
                current_row = next_row;
            }
        }
    }
}
