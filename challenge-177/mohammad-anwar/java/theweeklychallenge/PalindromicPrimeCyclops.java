package theweeklychallenge;

/*

Week 177:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-177

Task #2: Palindromic Prime Cyclops

    Write a script to generate first 20 Palindromic Prime Cyclops Numbers.

Compile and Run:

    mohammad-anwar/java$ javac theweeklychallenge/PalindromicPrimeCyclops.java
    mohammad-anwar/java$ java  theweeklychallenge.PalindromicPrimeCyclops

*/

import java.util.Arrays;
import junit.framework.TestCase;
import static junit.framework.Assert.*;

public class PalindromicPrimeCyclops extends TestCase {

    public static void main(String[] args) {
        junit.textui.TestRunner.run(
            theweeklychallenge.PalindromicPrimeCyclops.class);
    }

    public void testPalindromicPrimeCyclops() {
        int[] exp = {
            101,   16061,   31013,   35053,   38083,   73037,   74047,
          91019,   94049, 1120211, 1150511, 1160611, 1180811, 1190911,
        1250521, 1280821, 1360631, 1390931, 1490941, 1520251,
        };

        int[] got = getPalindromicPrimeCyclops(20);

        assertEquals(Arrays.toString(exp), Arrays.toString(got));
    }

    public static int[] getPalindromicPrimeCyclops(int num) {
        int[] n = new int[num];
        int   i = 0;
        int   j = 101;
        while (i < num) {
            if (   isPalindrome(j)
                && isPrime(j)
                && isCyclops(j) ) {
                n[i] = j;
                i = i + 1;
            }
            j = j + 2;
        }

        return n;
    }

    public static boolean isCyclops(int n) {
        int[] digits = getDigitsOf(n);
        int l        = digits.length;
        int m        = (int)(l - 1) / 2;

        if (   (l % 2 == 0)
            || (digits[m] != 0)
            || (grep(range(digits, 0, m), 0))
            || (grep(range(digits, m+1, l), 0)) ) {
            return false;
        }

        return true;
    }

    public static int[] range(int[] array, int start, int end){
        int r[] = new int[end - start];
        for(int i = 0; i <= end - start - 1; i++){
            r[i] = array[i + start];
        }

        return r;
    }

    public static boolean grep(int[] list, int s) {
        for (int i = 0; i < list.length; i++) {
            if (list[i] == s) {
                return true;
            }
        }

        return false;
    }

    public static boolean isPalindrome(int n) {
        int r = 0;
        int s = 0;
        int t = n;

        while (n > 0 ) {
             r = n % 10;
             s = (s * 10) + r;
               n = n / 10;
        }

        return (t == s);
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

    public static int[] getDigitsOf(int number) {
        String num  = String.valueOf(number);
        int array[] = new int[num.length()];

        for (int i = 0; i < num.length(); i++) {
            array[i] = Character.getNumericValue(num.charAt(i));
        }

        return array;
    }
}
