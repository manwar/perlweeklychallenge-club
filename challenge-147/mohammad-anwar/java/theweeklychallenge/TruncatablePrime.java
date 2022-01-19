package theweeklychallenge;

/*

Week 147:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-147

Task #1: Truncatable Prime

    Write a script to generate first 20 left-truncatable prime numbers in base 10.

*/

import java.lang.Math;
import java.util.Arrays;
import java.util.ArrayList;
import junit.framework.TestCase;
import java.util.regex.Pattern;
import java.util.regex.Matcher;
import static junit.framework.Assert.*;

public class TruncatablePrime extends TestCase {

    public static void main(String[] args) {
        junit.textui.TestRunner.run(theweeklychallenge.TruncatablePrime.class);
    }

    public void testTruncatablePrime() {
        Integer exp[] = {2, 3, 5, 7, 13, 17, 23, 37, 43, 47, 53, 67, 73, 83, 97, 113, 137, 167, 173, 197};
        Integer got[] = leftTruncatablePrime(20);
        assertTrue(Arrays.equals(exp, got));
    }

    public static Integer[] leftTruncatablePrime(int count) {
        ArrayList<Integer> ltp = new ArrayList<Integer>();
        int c = 0;
        int n = 2;
        while (c < count) {
            String s = Integer.toString(n);

            if (!Pattern.compile(".*0.*").matcher(s).matches() && isPrime(n)) {
                Integer[] numbers = leftTruncatableNumbers(n);
                boolean found = true;
                if (numbers.length >=2) {
                    for(int i = 0; i<numbers.length; i++) {
                        if (!isPrime(numbers[i])) {
                            found = false;
                        }
                    }
                }
                if (found) {
                    ltp.add(n);
                    c++;
                }
            }
            n++;
        }

        Integer[] ltpArray = new Integer[ltp.size()];
        return ltp.toArray(ltpArray);
    }

    public static Integer[] leftTruncatableNumbers(int n) {
        int i = 0;
        String s = Integer.toString(n);
        ArrayList<Integer> numbers = new ArrayList<Integer>();
        while (i < s.length()) {
            numbers.add(Integer.valueOf(s.substring(i)));
            i++;
        }

        Integer[] numArray = new Integer[numbers.size()];
        return numbers.toArray(numArray);
    }

    public static boolean isPrime(int n) {
        if (n == 1) {
            return false;
        }

        for(int i=2; i <= Math.sqrt(n); i++) {
            if ((n % i) == 0) {
                return false;
            }
        }

        return true;
    }
}
