import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

public class Ch2 {
  public static void main(String[] args) {
    System.out.println(Arrays.toString(relativeSort(
      new int[]{2, 3, 9, 3, 1, 4, 6, 7, 2, 8, 5},
      new int[]{2, 1, 4, 3, 5, 6}
    )));
    System.out.println(Arrays.toString(relativeSort(
      new int[]{3, 3, 4, 6, 2, 4, 2, 1, 3},
      new int[]{1, 3, 2}
    )));
    System.out.println(Arrays.toString(relativeSort(
      new int[]{3, 0, 5, 0, 2, 1, 4, 1, 1},
      new int[]{1, 0, 3, 2}
    )));
  }

  public static int[] relativeSort(int[] arr1, int[] arr2) {
    Map<Integer, Integer> ranks = new HashMap<>();
    Map<Integer, Boolean> ranked = new HashMap<>();
    for (int i = 0; i < arr2.length; i++) ranks.put(arr2[i], i);
    for (int num : arr1) ranked.put(num, ranks.containsKey(num));
    return Arrays.stream(arr1)
      .boxed()
      .sorted((a, b) -> {
        int rankedComparison = Boolean.compare(ranked.get(b), ranked.get(a));
        if (rankedComparison != 0) return rankedComparison;
        int rankA = ranks.getOrDefault(a, Integer.MAX_VALUE);
        int rankB = ranks.getOrDefault(b, Integer.MAX_VALUE);
        int rankComparison = Integer.compare(rankA, rankB);
        if (rankComparison != 0) return rankComparison;
        return Integer.compare(a, b);
      })
      .mapToInt(Integer::intValue)
      .toArray();
  }
}

