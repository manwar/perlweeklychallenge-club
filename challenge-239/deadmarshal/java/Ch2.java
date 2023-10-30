import java.util.List;
import java.util.ArrayList;

public class Ch2 {
  public static void main(String[] args) {
    ArrayList<String> list1 =
      new ArrayList<>(List.of("ad","bd","aaab","baa","badab"));
    ArrayList<String> list2 =
      new ArrayList<>(List.of("a","b","c","ab","ac","bc","abc"));
    ArrayList<String> list3 =
      new ArrayList<>(List.of("cc","acd","b","ba","bac","bad","ac","d"));
    System.out.println(consistent_strings(list1,"ab"));
    System.out.println(consistent_strings(list2,"abc"));
    System.out.println(consistent_strings(list3,"cad"));
  }

  private static int consistent_strings(List<String> list,
					String allowed) {
    int count = 0;
    for(var str : list) {
      boolean b = true;
      for(var c : str.toCharArray()) {
	if(allowed.indexOf(c) == -1) {
	  b = false;
	  break;
	}
      }
      if(b) count++;
    }
    return count;
  }
}

