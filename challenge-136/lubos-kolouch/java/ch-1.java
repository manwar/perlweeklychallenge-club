import java.math.*;

public class Main {
  static int gcd(int a, int b) {
    if (b == 0)
      return a;
    return gcd(b, a % b);
  }

  static boolean isPowerOfTwo(int n) { return (n & (n - 1)) == 0; }

  static boolean isTwoFriendly(int m, int n) { return isPowerOfTwo(gcd(m, n)); }

  public static void main(String[] args) {
    System.out.println(isTwoFriendly(8, 24) ? "1" : "0");
    System.out.println(isTwoFriendly(26, 39) ? "1" : "0");
    System.out.println(isTwoFriendly(4, 10) ? "1" : "0");
  }
}
