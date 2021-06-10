
import java.util.HashMap;
import java.util.Map;

public class SelfDescriptiveNumber {

    public static void main(String[] args) {
        int count = 0;
        int i = 1;
        while (true) {
            if (count == 3) {
                break;
            }
            if (isSelfDescriptiveNumber(i)) {
                System.out.println(i);
                count++;
            }
            i++;
        }
    }

    private static boolean isSelfDescriptiveNumber(int number) {
        String valueAsString = Integer.valueOf(number).toString();
        Map<Integer, Integer> map = new HashMap(valueAsString.length());
        for (int i = 0; i < valueAsString.length(); i++) {
            final int c = Character.getNumericValue(valueAsString.charAt(i));
            if (map.containsKey(c)) {
                map.put(c, map.get(c) + 1);
            } else {
                map.put(c, 1);
            }
        }
        for (int i = 0; i < valueAsString.length(); i++) {
            int c = Character.getNumericValue(valueAsString.charAt(i));
            if (map.getOrDefault(i, 0) != c) {
                return false;
            }
        }
        return true;
    }


}

