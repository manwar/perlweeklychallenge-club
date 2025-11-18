import java.util.Set;

public class Ch1 {
  public static void main(String[] args) {
    System.out.println(string_alike("textbook"));
    System.out.println(string_alike("book"));
    System.out.println(string_alike("AbCdEfGh"));
    System.out.println(string_alike("rhythmmyth"));
    System.out.println(string_alike("UmpireeAudio"));
  }

  private static boolean string_alike(String s) {
    int mid = s.length() / 2;
    int a = count_vowels(s.substring(0,mid));
    int b = count_vowels(s.substring(mid));
    return a == b && a != 0;
  }

  private static int count_vowels(String s) {
    int count = 0;
    for(char c : s.toLowerCase().toCharArray()) {
      switch(c) {
      case 'a','e','i','o','u' -> count++;
      }
    }
    return count;
  }
}

