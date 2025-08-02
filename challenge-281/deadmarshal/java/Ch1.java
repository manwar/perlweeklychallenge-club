public class Ch1 {
  public static void main(String[] args) {
    System.out.println(check_color("d3"));
    System.out.println(check_color("g5"));
    System.out.println(check_color("e6"));
  }

  private static boolean check_color(String str) {
    assert str.length() == 2;
    return (str.charAt(0) + str.charAt(1)) % 2 == 1;
  }
}

