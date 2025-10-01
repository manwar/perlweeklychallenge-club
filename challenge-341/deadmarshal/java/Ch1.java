public class Ch1 {
  public static void main(String[] args) {
    System.out.println(broken_keyboard("Hello World",
				       new char[]{'d'}));
    System.out.println(broken_keyboard("apple banana cherry",
				       new char[]{'a','e'}));
    System.out.println(broken_keyboard("Coding is fun",
				       new char[]{}));
    System.out.println(broken_keyboard("The Weekly Challenge",
				       new char[]{'a','b'}));
    System.out.println(broken_keyboard("Perl and Python",
				       new char[]{'p'}));
  }

  private static int broken_keyboard(String str,char[] chars) {
    String keys = new String(chars);
    String[] words = str.split("\\s+");
    if(keys.isEmpty()) return words.length;
    int c = 0;
    for(String w : words) {
      if(!containsAny(w.toLowerCase(),keys)) c++;
    }
    return c;
  }

  private static boolean containsAny(String word,String chars) {
    for(char c : chars.toCharArray()) {
      if(word.indexOf(c) != -1) return true;
    }
    return false;
  }
}

