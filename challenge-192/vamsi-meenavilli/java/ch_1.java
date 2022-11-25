import org.junit.jupiter.api.Test;
import java.util.HashMap;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.assertEquals;

/*
Week 192:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-192

	Task 1: Binary Flip
	You are given a positive integer, $n.
	Write a script to find the binary flip.

*/
public class main {
    public static Map<Character, Character> binaryNumberMap = new HashMap();

    static {
        binaryNumberMap.put('0', '1');
        binaryNumberMap.put('1', '0');
    }

    public static void main(String[] args) {}

    public static Integer binaryFlip(Integer number) {
        var flippedBinaryNumber = new StringBuilder();

        for (char c : Integer.toBinaryString(number).toCharArray()) {
            flippedBinaryNumber.append(binaryNumberMap.get(c));
        }

        return Integer.parseInt(flippedBinaryNumber.toString(), 2);
    }

    @Test
    public void binaryFlipTest() {
        assertEquals(binaryFlip(5), 2, "Example 1 Failed.");
        assertEquals(binaryFlip(4), 3, "Example 2 Failed.");
        assertEquals(binaryFlip(6), 1, "Example 3 Failed.");
    }
}
