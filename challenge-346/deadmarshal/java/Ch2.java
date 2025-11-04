import java.util.List;
import java.util.ArrayList;

public class Ch2 {
  public static void main(String[] args) {
    var s = new Solution();
    System.out.println(s.magic_expression("123",6));
    System.out.println(s.magic_expression("105",5));
    System.out.println(s.magic_expression("232",8));
    System.out.println(s.magic_expression("1324",10));
    System.out.println(s.magic_expression("1001",2));
  }
}

class Solution {
  private List<String> ans;
  private String num;
  private int target;

  public Solution() {
    this.ans = null;
    this.num = "";
    this.target = 0;
  }
  
  public List<String> magic_expression(String num,int target) {
    ans = new ArrayList<>();
    this.num = num;
    this.target = target;
    dfs(0,0,0,"");
    return ans;
  }

  private void dfs(int u, long prev, long curr, String path) {
    if(u == num.length()) {
      if(curr == target) ans.add(path);
      return;
    }
    for(int i = u; i < num.length(); i++) {
      if(i != u && num.charAt(u) == '0') break;
      long next = Long.parseLong(num.substring(u,i+1));
      if(u == 0) {
	dfs(i+1,next,next,path+next);
      } else {
	dfs(i+1,next,curr+next,path+"+"+next);
	dfs(i+1,-next,curr-next,path+"-"+next);
	dfs(i+1,prev*next,curr-prev+prev*next,path+"*"+next);
      }
    }
  }
}

