package theweeklychallenge;

/*

Week 173:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-173

Task #2: Sylvester’s sequence

    Write a script to generate first 10 members of Sylvester's sequence.

Compile and Run:

    mohammad-anwar/java$ javac theweeklychallenge/SylvesterSequence.java
    mohammad-anwar/java$ java  theweeklychallenge.SylvesterSequence

*/

import java.lang.Math;
import java.util.Arrays;
import java.util.ArrayList;
import java.math.BigInteger;
import junit.framework.TestCase;
import static junit.framework.Assert.*;

public class SylvesterSequence extends TestCase {

    public static void main(String[] args) {
        junit.textui.TestRunner.run(
            theweeklychallenge.SylvesterSequence.class);
    }

    public void testSylvesterSequence() {
        BigInteger exp[] = {
             BigInteger.valueOf(2)
            ,BigInteger.valueOf(3)
            ,BigInteger.valueOf(7)
            ,BigInteger.valueOf(43)
            ,BigInteger.valueOf(1807)
            ,BigInteger.valueOf(3263443)
            ,new BigInteger("10650056950807")
            ,new BigInteger("113423713055421844361000443")
            ,new BigInteger("12864938683278671740537145998360961546653259485195807")
            ,new BigInteger("165506647324519964198468195444439180017513152706377497841851388766535868639572406808911988131737645185443")
        };

        BigInteger got[] = sylvesterSequence(10);

        assertTrue(Arrays.equals(exp, got));
    }

    public static BigInteger[] sylvesterSequence(int n) {
        ArrayList<BigInteger> _ss = new ArrayList<BigInteger>();
        _ss.add(BigInteger.valueOf(2));
        int i = 1;
        while (i++ <= n - 1) {
            BigInteger m  = _ss.get(_ss.size() - 1);
            _ss.add((m.multiply(m.subtract(BigInteger.valueOf(1)))).add(BigInteger.valueOf(1)));
        }

        BigInteger[] ss = new BigInteger[_ss.size()];
        return _ss.toArray(ss);
    }
}
