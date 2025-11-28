public class Ch2 {
  public static void main(String[] args) {
    System.out.println(meeting_point("ULD"));
    System.out.println(meeting_point("ULDR"));
    System.out.println(meeting_point("UUURRRDDD"));
    System.out.println(meeting_point("UURRRDDLLL"));
    System.out.println(meeting_point("RRUULLDDRRUU"));
  }

  private static boolean meeting_point(String s) {
    int x = 0, y = 0;
    for(char c : s.toCharArray()) {
      if(c == 'U') ++y;
      else if(c == 'R') ++x;
      else if(c == 'D') --y;
      else if(c == 'L') --x;
    }
    return x == 0 && y == 0;
  }
}

