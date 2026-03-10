import java.math.BigInteger;

public class ch_1 {
    private static boolean isPrime(BigInteger n) {
        return n.compareTo(BigInteger.ONE) > 0 && n.isProbablePrime(50);
    }

    public static void main(String[] args) {
        int p = 2;
        BigInteger euclid = BigInteger.valueOf(3);

        while (isPrime(euclid)) {
            p++;
            while (!BigInteger.valueOf(p).isProbablePrime(50)) {
                p++;
            }

            BigInteger two = BigInteger.valueOf(2);
            BigInteger a = two.pow(p - 1);
            BigInteger b = two.pow(p).subtract(BigInteger.ONE);
            euclid = a.multiply(b);
        }

        System.out.println("The smallest Euclid number that is not prime is: " + euclid);
    }
}
