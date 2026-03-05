import java.math.BigDecimal;
import java.math.MathContext;
import java.math.RoundingMode;

/**
 * Perl Weekly Challenge 006 - Task 2.
 * Calculate Ramanujan's constant (e^(pi * sqrt(163))) to at least 32 decimal places.
 */
public class Challenge006Task2 {

    // Pi to 100 decimal places
    private static final BigDecimal PI = new BigDecimal("3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679");

    /**
     * Calculates e^x using the Taylor series expansion:
     * e^x = 1 + x + x^2/2! + x^3/3! + ...
     *
     * @param x  The exponent.
     * @param mc The MathContext for precision.
     * @return e^x.
     */
    public static BigDecimal exp(BigDecimal x, MathContext mc) {
        BigDecimal result = BigDecimal.ONE;
        BigDecimal term = BigDecimal.ONE;

        for (int i = 1; i < 2000; i++) {
            term = term.multiply(x).divide(BigDecimal.valueOf(i), mc);
            result = result.add(term);
            if (term.abs().compareTo(BigDecimal.valueOf(1e-100)) < 0) {
                break;
            }
        }
        return result;
    }

    /**
     * Calculates sqrt(x) using Newton's method.
     *
     * @param value The value to calculate sqrt for.
     * @param mc    The MathContext for precision.
     * @return sqrt(x).
     */
    public static BigDecimal sqrt(BigDecimal value, MathContext mc) {
        if (value.signum() < 0) {
            throw new ArithmeticException("Square root of negative number");
        }
        if (value.signum() == 0) {
            return BigDecimal.ZERO;
        }

        BigDecimal two = BigDecimal.valueOf(2);
        BigDecimal x0 = BigDecimal.valueOf(Math.sqrt(value.doubleValue()));
        if (Double.isInfinite(x0.doubleValue())) {
            x0 = value.divide(two, mc);
        }

        BigDecimal x1 = BigDecimal.ZERO;
        for (int i = 0; i < 1000; i++) {
            x1 = value.divide(x0, mc);
            x1 = x1.add(x0);
            x1 = x1.divide(two, mc);

            if (x0.subtract(x1).abs().compareTo(BigDecimal.valueOf(1e-100)) <= 0) {
                return x1;
            }
            x0 = x1;
        }
        return x1;
    }

    public static void main(String[] args) {
        int precision = 80; // Higher precision
        MathContext mc = new MathContext(precision, RoundingMode.HALF_UP);

        BigDecimal sqrt163 = sqrt(new BigDecimal("163"), mc);
        BigDecimal exponent = PI.multiply(sqrt163, mc);

        // Use scaling to improve convergence: e^x = (e^(x/2^k))^(2^k)
        int k = 8;
        BigDecimal xReduced = exponent.divide(BigDecimal.valueOf(1L << k), mc);
        BigDecimal eReduced = exp(xReduced, mc);

        BigDecimal result = eReduced;
        for (int i = 0; i < k; i++) {
            result = result.multiply(result, mc);
        }

        // Display 32 decimal places
        System.out.println(result.setScale(32, RoundingMode.HALF_UP).toPlainString());
    }
}
