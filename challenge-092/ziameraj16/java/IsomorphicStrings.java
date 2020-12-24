import java.util.*;

public class IsomorphicStrings {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter first string");
        String str1 = scanner.next();
        System.out.println("Enter second string");
        String str2 = scanner.next();
        System.out.println("Output: " + areStringIsomorphic(str1, str2));
    }

    public static int areStringIsomorphic(String str1, String str2) {
        Set<Character> set1 = convertToSet(str1);
        Set<Character> set2 = convertToSet(str2);
        if (set1.size() != set2.size()) {
            return 0;
        }
        Map<Character, Character> map = new HashMap();
        Iterator<Character> itr1 = set1.iterator();
        Iterator<Character> itr2 = set2.iterator();
        while (itr1.hasNext()) {
            final Character character = itr1.next();
            if (map.containsKey(character)) {
                if (!map.get(character).equals(itr2.next())) {
                   return 0;
                }
            } else {
                map.put(character, itr2.next());
            }
        }
        return 1;
    }

    private static Set<Character> convertToSet(String str) {
        Set<Character> set = new LinkedHashSet(str.length());
        for (int i = 0; i < str.length(); i++) {
            set.add(Character.valueOf(str.charAt(i)));
        }
        return set;
    }
}

