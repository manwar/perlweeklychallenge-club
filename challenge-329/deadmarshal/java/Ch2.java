import java.util.HashSet;
import java.util.Set;

public class Ch2 {
  public static void main(String[] args) {
    System.out.println(nice_string("YaaAho"));
    System.out.println(nice_string("cC"));
    System.out.println(nice_string("A"));
  }

  private static String nice_string(String s) {
    int n = s.length(), k = -1, max = 0;
    for (int i = 0; i < n; ++i) {
      Set<Character> sc = new HashSet<>();
      for (int j = i; j < n; ++j) {
        sc.add(s.charAt(j));
        boolean ok = true;
        for (char a : sc) {
          char b = (char) (a ^ 32);
          if (!(sc.contains(a) && sc.contains(b))) {
            ok = false;
            break;
          }
        }
        if (ok && (max < j - i + 1)) {
          max = j - i + 1;
          k = i;
        }
      }
    }
    return k == -1 ? "" : s.substring(k, k + max);
  }
}

