public class Ch1 {
  public static void main(String[] args) {
    System.out.println(last_word("The Weekly Challenge"));
    System.out.println(last_word("    Hello World    "));
    System.out.println(last_word("Let's begin the fun"));
  }

  private static int last_word(String s) {
    String[] arr = s.trim().split(" ");
    return arr[arr.length - 1].length();
  }
}
