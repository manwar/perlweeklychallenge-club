import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.stream.Collectors;

public class Ch1 {
  public static void main(String[] args) {
    List<String> list1 =
      new ArrayList<>(List.of("aba","aabb","abcd","bac","aabc"));
    List<String> list2 =
      new ArrayList<>(List.of("aabb","ab","ba"));
    List<String> list3 =
      new ArrayList<>(List.of("nba","cba","dba"));
    System.out.println(similar_words(list1));
    System.out.println(similar_words(list2));
    System.out.println(similar_words(list3));
  }

  private static int similar_words(List<String> list){
    int count = 0;
    HashMap<String,Integer> hashMap = new HashMap<>();
    for(String str : list){
      var s = Arrays.stream(str.split(""))
        .sorted()
        .distinct()
        .collect(Collectors.joining(""));
      int c = hashMap.getOrDefault(s,0);
      hashMap.put(s,c+1);
    }
    for(var i : hashMap.values()) count += (i * (i-1) / 2);
    return count;
  }
}
