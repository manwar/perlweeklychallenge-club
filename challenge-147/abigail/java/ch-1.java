//
// See https://theweeklychallenge.org/blog/perl-weekly-challenge-147
//

//
// Run as: ln ch-1.java ch1.java; javac ch1.java; java ch1
//

import java.util.*;
import java.util.ArrayList;

public class ch1 {
    public static boolean is_prime (int p) {
        if (p == 2)     {return true;}
        if (p % 2 == 0) {return false;}
        for (int i = 3; i * i <= p; i += 2) {
            if (p % i == 0) {return false;}
        }
        return (true);
    }

    public static void main (String [] args) {
        ArrayList <Integer> todo = new ArrayList <Integer> ();
        todo . add (2);
        todo . add (3);
        todo . add (5);
        todo . add (7);
        for (int p: todo) {
            System . out . printf ("%d ", p);
        }
        int count = 20 - todo . size ();
        int pow   = 10;
      main:
        while (todo . size () > 0) {
            ArrayList <Integer> new_todo = new ArrayList <Integer> ();
            for (int d = 1; d <= 9; d ++) {
                for (int p: todo) {
                    int candidate = d * pow + p;
                    if (is_prime (candidate)) {
                        System . out . printf ("%d ", candidate);
                        new_todo . add (candidate);
                        count --;
                        if (count <= 0) {
                            break main;
                        }
                    }
                }
            }
            pow = pow * 10;
            todo = new_todo;
        }
        System . out . print ("\n");
    }
}
