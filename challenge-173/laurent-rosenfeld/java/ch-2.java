import java.math.BigInteger;

public class Sylvester {
    public static void main(String[] args) {
        BigInteger n = BigInteger.valueOf(2);
        System.out.printf("%s\n", n);
        BigInteger one = BigInteger.valueOf(1);
        for (int i = 1; i <= 9; i++) {
            n = (n.multiply(n.subtract(one))).add(one);
            System.out.printf("%s\n", n);
        }
    }
}
