public class Ch2 {
  public static void main(String[] args) {
    System.out.println(find_celebrity(new int[][]{{0,0,0,0,1,0},
						  {0,0,0,0,1,0},
						  {0,0,0,0,1,0},
						  {0,0,0,0,1,0},
						  {0,0,0,0,0,0},
						  {0,0,0,0,1,0}}));
    System.out.println(find_celebrity(new int[][]{{0, 1, 0, 0},
						  {0,0,1,0},
						  {0,0,0,1},
						  {1,0,0,0}}));
    System.out.println(find_celebrity(new int[][]{{0, 0, 0, 0, 0},
						  {1, 0, 0, 0, 0},
						  {1, 0, 0, 0, 0},
						  {1, 0, 0, 0, 0},
						  {1, 0, 0, 0, 0}}));
    System.out.println(find_celebrity(new int[][]{{0, 1, 0, 1, 0, 1},
						  {1, 0, 1, 1, 0, 0},
						  {0, 0, 0, 1, 1, 0},
						  {0, 0, 0, 0, 0, 0},
						  {0, 1, 0, 1, 0, 0},
						  {1, 0, 1, 1, 0, 0}}));
    System.out.println(find_celebrity(new int[][]{{0, 1, 1, 0},
						  {1, 0, 1, 0},
						  {0, 0, 0, 0},
						  {0, 0, 0, 0}}));
    System.out.println(find_celebrity(new int[][]{{0, 0, 1, 1},
						  {1, 0, 0, 0},
						  {1, 1, 0, 1},
						  {1, 1, 0, 0}}));
  }
  
  private static int find_celebrity(int[][] party) {
    int n = party.length;
    if(n == 0) return -1;
    int cand = 0;
    for(int i = 1; i < n; i++) {
      if(party[cand][i] == 1) cand = i;
    }
    for(int i = 0; i < n; i++) {
      if(i == cand) continue;
      if(party[cand][i] == 1 || party[i][cand] != 1) return -1;
    }
    return cand;
  }
}

