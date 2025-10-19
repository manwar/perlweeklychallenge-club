import java.util.Map;
import java.util.HashMap;

public class Ch2 {
  public void main(String[] args) {
    System.out.println(
        champion_team(new int[][] { { 0, 1, 1 }, { 0, 0, 1 }, { 0, 0, 0 } }));
    System.out.println(champion_team(new int[][] { { 0, 1, 0, 0 },
        { 0, 0, 0, 0 }, { 1, 1, 0, 0 }, { 1, 1, 1, 0 } }));
    System.out.println(champion_team(new int[][] { { 0, 1, 0, 1 },
        { 0, 0, 1, 1 }, { 1, 0, 0, 0 }, { 0, 0, 1, 0 } }));
    System.out.println(
        champion_team(new int[][] { { 0, 1, 1 }, { 0, 0, 0 }, { 0, 1, 0 } }));
    System.out.println(
        champion_team(new int[][] { { 0, 0, 0, 0, 0 }, { 1, 0, 0, 0, 0 },
            { 1, 1, 0, 1, 1 }, { 1, 1, 0, 0, 0 }, { 1, 1, 0, 1, 0 } }));
  }

  private static int champion_team(int[][] grid) {
    int m = 0;
    Map<Integer,Integer> h = new HashMap<>();
    for(int y = 0; y < grid.length; ++y) {
      for(int x = 0; x < grid[y].length; ++x) {
	int w = grid[y][x] == 1 ? y : x;
	h.put(w,h.getOrDefault(w,0) + 1);
	if(h.get(w) > h.getOrDefault(m,0)) m = w;
      }
    }
    return m;
  }
}

