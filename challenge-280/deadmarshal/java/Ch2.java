public class Ch2 {
  public static void main(String[] args) {
    System.out.println(count_asterisks("p|*e*rl|w**e|*ekly|"));
    System.out.println(count_asterisks("perl"));
    System.out.println(count_asterisks("th|ewe|e**|k|l***ych|alleng|e"));
  }

  private static int count_asterisks(String str) {
    String[] arr = str.split("\\|");
    int count = 0;
    for (int i = 0; i < arr.length; ++i) {
      if (i % 2 == 0) {
        for (int j = 0; j < arr[i].length(); ++j)
          if (arr[i].charAt(j) == '*') count++;
      }
    }
    return count;
  }
}
