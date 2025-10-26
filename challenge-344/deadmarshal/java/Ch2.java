public class Ch2 {
  public static void main(String[] args) {
    System.out.println(array_formation(new int[][]{{2,3},{1},{4}},
				       new int[]{1,2,3,4}));
    System.out.println(array_formation(new int[][]{{1,3},{2,4}},
				       new int[]{1,2,3,4}));
    System.out.println(array_formation(new int[][]{{9,1},{5,8},{2}},
				       new int[]{5,8,2,9,1}));
    System.out.println(array_formation(new int[][]{{1},{3}},
				       new int[]{1,2,3}));
    System.out.println(array_formation(new int[][]{{7,4,6}},
				       new int[]{7,4,6}));
  }

  private static boolean array_formation(int[][]source,
					 int[] target) {
    for(int i = 0; i < target.length;) {
      int k = 0;
      while(k < source.length && source[k][0] != target[i]) ++k;
      if(k == source.length) return false;
      int j = 0;
      while(j < source[k].length && target[i] == source[k][j]) {
	++i;
	++j;
      }
    }
    return true;
  }
}

