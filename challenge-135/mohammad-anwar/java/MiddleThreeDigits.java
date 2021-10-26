import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/*

Week 135:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-135

Task #1: Middle 3-digits

    You are given an integer.

    Write a script find out the middle 3-digits of the given integer, if possible otherwise throw sensible error.

*/

class MiddleThreeDigits {

    public static void main(String[] args) {
        String p = System.getProperty("number", "1234567");

        Pattern pattern = Pattern.compile("\\-?\\d+");
        if (pattern.matcher(p).find()) {

            int n = Math.abs(Integer.parseInt(p));
            int l = countDigits(n);
            if (l == 1) {
                System.out.println("ERROR: Too short.");
            }
            else if (l % 2 == 0) {
                System.out.println("ERROR: Even number of digists.");
            }
            else {
                int i = (l / 2) - 1;
                System.out.println(String.valueOf(n).substring(i, i+3));
            }

        }
        else {
            System.out.println("ERROR: Invalid number.");
        }
    }

    public static int countDigits(int n) {
        int l = 0;
        for(; n != 0; n /= 10, ++l);
        return l;
    }

}
