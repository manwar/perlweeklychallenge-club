public class Main {
  static int countDivisorsWithLastDigit(int m, int n) {
    int count = 0;
    for (int i = 1; i <= m; i++) {
      if (m % i == 0 && i % 10 == n) {
        count++;
      }
    }
    return count;
  }

  public static void main(String[] args) {
    System.out.println(countDivisorsWithLastDigit(24, 2));
    System.out.println(countDivisorsWithLastDigit(30, 5));
  }
}
