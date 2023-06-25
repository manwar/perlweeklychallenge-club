import java.util.Collections;
import java.util.PriorityQueue;

public class ch2 {
  public static void main(String[] args) {
    System.out.println(lastMember(new int[] {2, 7, 4, 1, 8, 1}));
    System.out.println(lastMember(new int[] {1}));
    System.out.println(lastMember(new int[] {1, 1}));
  }

  public static int lastMember(int[] ints) {
    PriorityQueue<Integer> pq = new PriorityQueue<>(Collections.reverseOrder());
    for (int i : ints) {
      pq.offer(i);
    }

    while (pq.size() > 1) {
      int x = pq.poll();
      int y = pq.poll();

      if (x != y) {
        pq.offer(x - y);
      }
    }

    return pq.isEmpty() ? 0 : pq.poll();
  }
}
