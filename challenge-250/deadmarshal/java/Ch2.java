import java.util.ArrayList;
import java.util.List;
import java.lang.Integer;

public class Ch2 {
  public static void main(String[] args) {
    ArrayList<String> list1 =
	new ArrayList<>(List.of("perl","2","000","python","r4ku"));
    ArrayList<String> list2 =
	new ArrayList<>(List.of("001","1","000","0001"));
    System.out.println(alphanumeric_string_value(list1));
    System.out.println(alphanumeric_string_value(list2));
  }

  private static boolean is_numeric(String str) {
    try {
	Integer.parseInt(str);  
	return true;
    } catch(NumberFormatException e) {
	return false;
    }  
  }
    
  private static int alphanumeric_string_value(List<String> list) {
    int max = 0;
    for(var e : list){
      int n = is_numeric(e) ? Integer.parseInt(e) : e.length();
      if(n > max) max = n;
    }
    return max;
  }
} 

