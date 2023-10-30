import java.util.List;
import java.lang.StringBuilder;

public class Ch1 {
  public static void main(String[] args) {
    System.out.println(same_string(List.of("ab","c"),
				   List.of("a","bc")));
    System.out.println(same_string(List.of("ab","c"),
				   List.of("ac","b")));
    System.out.println(same_string(List.of("ab","cd","e"),
				   List.of("abcde")));    
  }

  private static boolean same_string(List<String> list1,
				     List<String> list2) {
    StringBuilder sb1 = new StringBuilder();
    StringBuilder sb2 = new StringBuilder();
    for(var e : list1) sb1.append(e);
    for(var e : list2) sb2.append(e);
    return sb1.toString().equals(sb2.toString());
  }
}

