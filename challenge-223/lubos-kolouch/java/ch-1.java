public class Main {
  public static void main(String[] args) {
    System.out.println(countPrimes(20)); // Outputs: 8
  }

  public static int countPrimes(int n) {
    boolean[] sieve = new boolean[n + 1];
    for (int i = 2; i <= n; i++)
      sieve[i] = true;

    for (int i = 2; i <= Math.sqrt(n); i++) {
      if (sieve[i]) {
        for (int j = i * i; j <= n; j += i) {
          sieve[j] = false;
        }
      }
    }

    int count = 0;
    for (int i = 2; i <= n; i++) {
      if (sieve[i])
        count++;
    }
    return count;
  }
}
