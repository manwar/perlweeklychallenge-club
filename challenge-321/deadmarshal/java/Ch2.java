public class Ch2 {
  public static void main(String[] args) {
    System.out.println(backspace_compare("ab#c", "ad#c"));
    System.out.println(backspace_compare("ab##", "a#b#"));
    System.out.println(backspace_compare("a#b", "c"));
  }

  private static boolean backspace_compare(String s1, String s2) {
    int i = s1.length() - 1, j = s2.length() - 1;
    int skip1 = 0, skip2 = 0;
    for (; i >= 0 || j >= 0; --i, --j) {
      while (i >= 0) {
        if (s1.charAt(i) == '#') {
          ++skip1;
          --i;
        } else if (skip1 > 0) {
          --skip1;
          --i;
        } else {
          break;
        }
      }
      while (j >= 0) {
        if (s2.charAt(j) == '#') {
          ++skip2;
          --j;
        } else if (skip2 > 0) {
          --skip2;
          --j;
        } else {
          break;
        }
      }
      if (i >= 0 && j >= 0) {
        if (s1.charAt(i) != s2.charAt(j)) return false;
      } else if (i >= 0 || j >= 0) return false;
    }
    return true;
  }
}

