import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

public class Ch1 {
  public static void main(String[] args) {
    try {
      System.out.println(sort_string("and2 Raku3 cousins5 Perl1 are4"));
      System.out.println(sort_string("guest6 Python1 most4 the3 popular5 is2 " +
				     "language7"));
      System.out.println(sort_string("Challenge3 The1 Weekly2"));
    } catch (Exception e) {
      System.err.println(e.getMessage());
    }
  }

  private static String sort_string(String str) throws Exception {
    Pattern pattern = Pattern.compile("(\\w+)(\\d+)");
    Map<String, Integer> m = new HashMap<>();
    for (String s : str.split(" ")) {
      Matcher matcher = pattern.matcher(s);
      if (matcher.find())
        m.put(matcher.group(1), Integer.parseInt(matcher.group(2)));
      else
        throw new Exception("Wrong format!");
    }
    return m.entrySet()
      .stream()
      .sorted(Map.Entry.comparingByValue())
      .map(Map.Entry::getKey)
      .collect(Collectors.joining(" "));
  }
}

