// Same algorithm as the perl version, using a LinkedHashMap to
// preserve order of keys, and streams to avoid most loops.

import java.util.*;

class ch2 {
    private static void task2(String s) {
        ArrayList<Character> chars = new ArrayList<Character>();
        chars.ensureCapacity(s.length());
        s.chars().forEach(ch -> chars.add((char)ch));
        Collections.reverse(chars);
        StringBuilder sb = new StringBuilder();
        while (chars.size() > 0) {
            HashMap<Character, Integer> counts =
                new LinkedHashMap<Character, Integer>();
            chars.stream().forEach(ch -> counts.put(ch, counts.getOrDefault(ch, 0) + 1));
            char fnr = counts.entrySet().stream()
                .filter(entry -> entry.getValue() == 1)
                .findFirst().map(entry -> entry.getKey()).orElse('#');
            sb.append(fnr);
            chars.remove(0);
        }
        sb.reverse();
        System.out.println(sb);
    }

    public static void main(String[] args) {
        task2("ababc");
        task2("xyzzyx");
    }
}
