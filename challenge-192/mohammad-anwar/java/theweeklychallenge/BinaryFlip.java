package theweeklychallenge;

/*

Week 192:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-192

Task #1: Binary Flip

    You are given a positive integer, $n.

    Write a script to find the binary flip.

Compile and Run:

    mohammad-anwar/java$ javac theweeklychallenge/BinaryFlip.java
    mohammad-anwar/java$ java  theweeklychallenge.BinaryFlip

*/

import junit.framework.TestCase;
import static junit.framework.Assert.*;

public class BinaryFlip extends TestCase {

    public static void main(String[] args) {
        junit.textui.TestRunner.run(
            theweeklychallenge.BinaryFlip.class
        );
    }

    public void testBinaryFlip() {
        assertEquals(2, binaryFlip(5));
        assertEquals(3, binaryFlip(4));
        assertEquals(1, binaryFlip(6));
    }

    public static int binaryFlip(int n) {
        String[]   bits = Integer.toBinaryString(n).split("");
        String  flipped = "";
        for(String bit : bits) {
            flipped += (bit.equals("0")) ? '1' : '0';
        }

        return Integer.parseInt(flipped, 2);
    }
}
