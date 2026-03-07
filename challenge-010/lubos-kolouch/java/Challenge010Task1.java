import java.util.LinkedHashMap;
import java.util.Map;

/**
 * Perl Weekly Challenge 010 - Task 1.
 * Roman Numeral Encoder and Decoder.
 */
public class Challenge010Task1 {

    private static final Map<String, Integer> ROMAN_MAP = new LinkedHashMap<>();

    static {
        ROMAN_MAP.put("M", 1000);
        ROMAN_MAP.put("CM", 900);
        ROMAN_MAP.put("D", 500);
        ROMAN_MAP.put("CD", 400);
        ROMAN_MAP.put("C", 100);
        ROMAN_MAP.put("XC", 90);
        ROMAN_MAP.put("L", 50);
        ROMAN_MAP.put("XL", 40);
        ROMAN_MAP.put("X", 10);
        ROMAN_MAP.put("IX", 9);
        ROMAN_MAP.put("V", 5);
        ROMAN_MAP.put("IV", 4);
        ROMAN_MAP.put("I", 1);
    }

    public static String encodeRoman(int number) {
        StringBuilder sb = new StringBuilder();
        int remaining = number;
        for (Map.Entry<String, Integer> entry : ROMAN_MAP.entrySet()) {
            while (remaining >= entry.getValue()) {
                sb.append(entry.getKey());
                remaining -= entry.getValue();
            }
        }
        return sb.toString();
    }

    public static int decodeRoman(String roman) {
        int result = 0;
        String remaining = roman;
        for (Map.Entry<String, Integer> entry : ROMAN_MAP.entrySet()) {
            while (remaining.startsWith(entry.getKey())) {
                result += entry.getValue();
                remaining = remaining.substring(entry.getKey().length());
            }
        }
        return result;
    }

    private static void runTests() {
        if (!encodeRoman(39).equals("XXXIX")) {
            throw new AssertionError("Test failed for encoding 39");
        }
        if (decodeRoman("XXXIX") != 39) {
            throw new AssertionError("Test failed for decoding XXXIX");
        }
        if (!encodeRoman(246).equals("CCXLVI")) {
            throw new AssertionError("Test failed for encoding 246");
        }
        if (decodeRoman("CCXLVI") != 246) {
            throw new AssertionError("Test failed for decoding CCXLVI");
        }
        System.out.println("ok - Challenge 010 Task 1 tests passed");
    }

    public static void main(String[] args) {
        if (args.length > 0 && "--test".equals(args[0])) {
            runTests();
            return;
        }

        if (args.length == 0) {
            System.out.println("246 = " + encodeRoman(246));
            System.out.println("CCXLVI = " + decodeRoman("CCXLVI"));
        } else {
            for (String arg : args) {
                try {
                    int n = Integer.parseInt(arg);
                    System.out.println(n + " = " + encodeRoman(n));
                } catch (NumberFormatException e) {
                    System.out.println(arg + " = " + decodeRoman(arg));
                }
            }
        }
    }
}
