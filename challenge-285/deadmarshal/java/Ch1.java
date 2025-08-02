import java.util.HashMap;
import java.util.Map;

public class Ch1 {
  public static void main(String[] args) {
    String[][] arr1 = {{"B", "C"}, {"D", "B"}, {"C", "A"}};
    String[][] arr2 = {{"A", "Z"}};
    System.out.println(no_connection(arr1));
    System.out.println(no_connection(arr2));
  }

  private static String no_connection(String[][] arr) {
    Map<String, Integer> destinations = new HashMap<>(),
      sources = new HashMap<>();
    for (String[] a : arr) {
      sources.put(a[0], 1);
      destinations.put(a[1], 1);
    }
    for (String d : destinations.keySet())
      if (!sources.containsKey(d)) return d;
    return "";
  }
}
