//
// See ../README.md
//

//
// Run as: ln ch-2.java ch2.java; javac ch2.java; java ch2 < input-file
//

import java.util.*;

public class ch2 {
    public static int base  = 10;
    public static int count = 10;
    public static int [] small_primes =
                        {2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31};

    public static int digitsum (int number) {
        int sum = 0;
        while (number > 0) {
            sum    += number % base;
            number /= base;
        }
        return (sum);
    }

    public static void main (String [] args) {
        int number = 1;
        int c = count;
        while (c > 0) {
            int ds_n = digitsum (++ number);
            int ds_f = 0;
            int n    = 0;
            int copy = number;
            for (int i = 0; i < small_primes . length && copy > 1; i ++) {
                int prime = small_primes [i];
                while (copy % prime == 0) {
                    ds_f += digitsum (prime);
                    n ++;
                    copy /= prime;
                }
            }
            if (copy > 1) {
                ds_f += digitsum (copy);
                n ++;
            }
            if (n > 1 && ds_n == ds_f) {
                System . out . println (number);
                c --;
            }
        }
    }
}
