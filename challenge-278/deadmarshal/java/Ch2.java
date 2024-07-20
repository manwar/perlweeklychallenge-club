import java.util.Arrays;

public class Ch2 {
  public static void main(String[] args) {
    System.out.println(reverse_string("challenge", 'e'));
    System.out.println(reverse_string("programming", 'a'));
    System.out.println(reverse_string("champion", 'b'));
  }

  private static String reverse_string(String str, char c) {
    int idx = str.indexOf(c);
    if (idx != -1) {
      char[] arr = str.substring(0, idx + 1).toCharArray();
      Arrays.sort(arr);
      return String.valueOf(arr) + str.substring(idx);
    }
    return str;
  }
}

