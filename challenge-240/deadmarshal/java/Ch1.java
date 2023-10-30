import java.util.List;
import java.util.ArrayList;

public class Ch1 {
  public static void main(String[] args) {
    ArrayList<String> list1 =
      new ArrayList<>(List.of("Perl", "Python", "Pascal"));
    ArrayList<String> list2 =
      new ArrayList<>(List.of("Perl", "Raku"));
    ArrayList<String> list3 =
      new ArrayList<String>(List.of("Oracle", "Awk", "C"));
    System.out.println(acronym(list1,"ppp"));
    System.out.println(acronym(list2,"rp"));
    System.out.println(acronym(list3,"oac"));
  }

  private static boolean acronym(List<String> list,String check) {
    StringBuilder sb = new StringBuilder();
    for(var str : list)
      sb.append(Character.toLowerCase(str.charAt(0)));
    return sb.toString().equals(check);
  }
}

