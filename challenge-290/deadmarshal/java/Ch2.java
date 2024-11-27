public class Ch2 {
  public static void main(String[] args) {
    System.out.println(luhns_algorithm("17893729974"));
    System.out.println(luhns_algorithm("4137 8947 1175 5904"));
    System.out.println(luhns_algorithm("4137 8974 1175 5904"));
  }

  private static boolean luhns_algorithm(String str) {
    String s = str.replaceAll("\\s+", "");
    int p = Integer.parseInt(String.valueOf(s.charAt(s.length() - 1)));
    int sum = 0;
    boolean even = false;
    for (int i = s.length() - 2; i >= 0; --i) {
      int d = Integer.parseInt(String.valueOf(s.charAt(i)));
      sum += even ? d : 2 * d > 9 ? 2 * d - 9 : 2 * d;
      even = !even;
    }
    return (sum + p) % 10 == 0;
  }
}
