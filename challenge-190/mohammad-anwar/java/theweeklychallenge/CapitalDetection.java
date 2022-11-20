package theweeklychallenge;

/*

Week 190:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-190

Task #1: Capital Detection

    You are given a string with alphabetic characters only:
    A..Z and a..z.

    Write a script to find out if the usage of Capital is appropriate
    if it satisfies at least one of the following rules:

    1) Only first letter is capital and all others are small.
    2) Every letter is small.
    3) Every letter is capital.

Compile and Run:

    mohammad-anwar/java$ javac theweeklychallenge/CapitalDetection.java
    mohammad-anwar/java$ java  theweeklychallenge.CapitalDetection

*/

import java.util.regex.Matcher;
import java.util.regex.Pattern;
import junit.framework.TestCase;
import static junit.framework.Assert.*;

public class CapitalDetection extends TestCase {

    static Pattern rule1 = Pattern.compile("^[A-Za-z]+$");
    static Pattern rule2 = Pattern.compile("^[A-Z][a-z]+$");
    static Pattern rule3 = Pattern.compile("^[a-z]+$");
    static Pattern rule4 = Pattern.compile("^[A-Z]+$");

    public static void main(String[] args) {
        junit.textui.TestRunner.run(
            theweeklychallenge.CapitalDetection.class
        );
    }

    public void testCapitalDetection() {
        assertTrue(capitalDetection("Perl"));
        assertTrue(capitalDetection("TPF"));
        assertFalse(capitalDetection("PyThon"));
        assertTrue(capitalDetection("raku"));
    }

    public static boolean capitalDetection(String name) {
        if (rule1.matcher(name).find()
            && (rule2.matcher(name).find()
                || rule3.matcher(name).find()
                || rule4.matcher(name).find())) {
            return true;
        }

        return false;
    }
}
