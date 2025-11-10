import java.util.Stack;

public class Ch1 {
  public static void main(String[] args) {
    System.out.println(longest_parenthesis("(()())"));
    System.out.println(longest_parenthesis(")()())"));
    System.out.println(longest_parenthesis("((()))()(((()"));
    System.out.println(longest_parenthesis("))))((()("));
    System.out.println(longest_parenthesis("()(()"));
  }

  private static int longest_parenthesis(String s) {
    Stack<Integer> stk = new Stack<>();
    stk.push(-1);
    int maxlen = 0;
    for(int i = 0; i < s.length(); ++i) {
      if(s.charAt(i) == '(') stk.push(i);
      else {
	stk.pop();
	if(stk.isEmpty()) stk.push(i);
	else maxlen = Math.max(maxlen,i-stk.peek());
      }
    }
    return maxlen;
  }
}

