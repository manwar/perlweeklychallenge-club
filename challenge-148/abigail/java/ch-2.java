//
// See https://theweeklychallenge.org/blog/perl-weekly-challenge-148
//

//
// Run as: ln ch-2.java ch2.java; javac ch2.java; java ch2
//

import java.util.*;

public class ch2 {
    public static void main (String [] args) {
        int COUNT = 5;
        int A     = 0;
        int B     = 1;
        int C     = 2;
        int SUM   = 3;

        int [] [] out = new int [COUNT] [4];
        for (int i = 0; i < COUNT; i ++) {
            out [i] [A]   = 999999;
            out [i] [B]   = 999999;
            out [i] [C]   = 999999;
            out [i] [SUM] = out [i] [A] + out [i] [B] + out [i] [C];
        }

        int max_index = 0;

        for (int k = 0; 3 * k + 2 <= out [max_index] [SUM]; k ++) {
            int a  = 3 * k + 2;
            int f1 =     k + 1;
            int f2 = 8 * k + 5;

            //
            // Find the divisors of f1
            //
            ArrayList <Integer> d1 = new ArrayList <Integer> ();
            for (int i = 1; i * i <= f1; i ++) {
                if (f1 % i == 0) {
                    d1 . add (i);
                    if (f1 / i != i) {
                        d1 . add (f1 / i);
                    }
                }
            }

            //
            // Find square divisors of f2
            //
            ArrayList <Integer> d2 = new ArrayList <Integer> ();
            for (int i = 1; i * i <= f2; i ++) {
                if (f2 % i == 0) {
                    int s1 = (int) Math . sqrt (i);
                    int s2 = (int) Math . sqrt (f2 / i);
                    if (s1 * s1 == i) {
                        d2 . add (s1);
                    }
                    if (s2 * s2 == f2 / i && s1 != s2) {
                        d2 . add (s2);
                    }
                }
            }

            for (int i = 0; i < d1 . size (); i ++) {
                for (int j = 0; j < d2. size (); j ++) {
                    int b = d1 . get (i) * d2 . get (j);
                    int c = f1 * f1 * f2 / (b * b);
                    if (a + b + c < out [max_index] [SUM]) {
                        boolean seen = false;
                        for (int m = 0; m < COUNT; m ++) {
                            if (out [m] [A] == a && out [m] [B] == b) {
                                seen = true;
                            }
                        }
                        if (seen) {
                            break;
                        }

                        out [max_index] [A]   = a;
                        out [max_index] [B]   = b;
                        out [max_index] [C]   = c;
                        out [max_index] [SUM] = a + b + c;

                        max_index = 0;
                        int max_sum = out [max_index] [SUM];
                        for (int l = 1; l < COUNT; l ++) {
                            if (out [l] [SUM] > max_sum) {
                                max_index = l;
                                max_sum   = out [l] [SUM];
                            }
                        }
                    }
                }
            }
        }

        //
        // Print the results
        //
        for (int i = 0; i < COUNT; i ++) {
            System . out . printf ("%d %d %d\n", out [i] [A], out [i] [B],
                                                              out [i] [C]);
        }
    }
}
