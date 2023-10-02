import java.util.*;

class Main {
  static Map<Integer, List<Integer>> tree = new HashMap<>();
  static {
    tree.put(1, Arrays.asList(2, 3));
    tree.put(3, Arrays.asList(4));
    tree.put(4, Arrays.asList(5, 6));
  }

  public static void main(String[] args) {
    System.out.println(distance(6, 1, 0));
    System.out.println(distance(5, 1, 0));
    System.out.println(distance(2, 1, 0));
    System.out.println(distance(4, 1, 0));
  }

  public static Integer distance(int node, int root, int dist) {
    if (root == node)
      return dist;
    if (tree.containsKey(root)) {
      for (int child : tree.get(root)) {
        Integer d = distance(node, child, dist + 1);
        if (d != null)
          return d;
      }
    }
    return null;
  }
}
