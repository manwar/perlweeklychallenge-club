import java.util.*;

public class Ch2 {
  public static void main(String[] args) {
    List<Integer> list1 = new ArrayList<>(List.of(1,1,2,2,2,3));
    List<Integer> list2 = new ArrayList<>(List.of(2,3,1,3,2));
    List<Integer> list3 = new ArrayList<>(List.of(-1,1,-6,4,5,-6,1,4,1));
    frequency_sort(list1);
    frequency_sort(list2);
    frequency_sort(list3);
    System.out.println(list1);
    System.out.println(list2);
    System.out.println(list3);
  }

  private static void frequency_sort(List<Integer> list){
    HashMap<Integer,Integer> hashMap = new HashMap<>();
    for(Integer i : list){
      int c = hashMap.getOrDefault(i,0);
      hashMap.put(i,c+1);
    }
    list.sort(new Comparator<>() {
      @Override
      public int compare(Integer t1, Integer t2) {
        int a = hashMap.get(t1);
        int b = hashMap.get(t2);
        return Objects.equals(a,b) ? Integer.compare(t2,t1)
          : Integer.compare(a,b);
      }
    });
  }
}
