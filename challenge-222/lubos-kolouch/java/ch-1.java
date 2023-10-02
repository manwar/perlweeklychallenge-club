import java.util.Arrays;

class ch1 {
  public static void main(String[] args) {
    System.out.println(countMatchingMembers(new int[] {1, 1, 4, 2, 1, 3}));
    System.out.println(countMatchingMembers(new int[] {5, 1, 2, 3, 4}));
    System.out.println(countMatchingMembers(new int[] {1, 2, 3, 4, 5}));
  }

  public static int countMatchingMembers(int[] ints) {
    int[] original = Arrays.copyOf(ints, ints.length);
    Arrays.sort(ints);

    int count = 0;
    for (int i = 0; i < ints.length; i++) {
      if (original[i] == ints[i]) {
        count++;
      }
    }

    return count;
  }
}
