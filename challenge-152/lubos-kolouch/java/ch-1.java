class MinPathFinder {

  static int get_min_count(int[][] in_arr) {
    int min_sum = 0;

    int i;
    for (i = 0; i < in_arr.length; i++) {
      int min = in_arr[i][0];

      int j;
      for (j = 0; j < in_arr[i].length; j++) {
        if (in_arr[i][j] < min) {
          min = in_arr[i][j];
        }
      }

      min_sum += min;
    }
    return min_sum;
  }

  public static void main(String[] args) {

    int[][] my_list = {{1}, {5, 3}, {2, 3, 4}, {7, 1, 0, 2}, {6, 4, 5, 2, 8}};

    if (get_min_count(my_list) != 8) {
      System.out.println("Failed test 1");
    }

    int[][] my_list2 = {{5}, {2, 3}, {4, 1, 5}, {0, 1, 2, 3}, {7, 2, 4, 1, 9}};

    if (get_min_count(my_list2) != 9) {
      System.out.println("Failed test 2");
    }
  }
}
