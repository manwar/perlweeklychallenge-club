public class Ch1 {
  public static void main(String[] args) {
    System.out.println(format_date("1st Jan 2025"));
    System.out.println(format_date("22nd Feb 2025"));
    System.out.println(format_date("15th Apr 2025"));
    System.out.println(format_date("23rd Oct 2025"));
    System.out.println(format_date("31st Dec 2025"));
  }

  private static String format_date(String date) {
    var s = date.split(" ");
    String months = "JanFebMarAprMayJunJulAugSepOctNovDec";
    int day = Integer.parseInt(s[0].substring(0, s[0].length() - 2));
    int month = months.indexOf(s[1]) / 3 + 1;
    return String.format("%s-%02d-%02d", s[2], month, day);
  }
}
