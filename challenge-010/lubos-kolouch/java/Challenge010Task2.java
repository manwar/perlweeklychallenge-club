import java.util.Arrays;

/**
 * Perl Weekly Challenge 010 - Task 2.
 * Jaro-Winkler Distance.
 */
public class Challenge010Task2 {

    public static double jaroWinklerDistance(String s1, String s2) {
        double jaro = jaroDistance(s1, s2);
        if (jaro == 0) return 0;

        int prefixLen = 0;
        int maxPrefix = 4;
        for (int i = 0; i < Math.min(s1.length(), Math.min(s2.length(), maxPrefix)); i++) {
            if (s1.charAt(i) == s2.charAt(i)) {
                prefixLen++;
            } else {
                break;
            }
        }

        double p = 0.1; // scaling factor
        return jaro + (prefixLen * p * (1 - jaro));
    }

    public static double jaroDistance(String s1, String s2) {
        int len1 = s1.length();
        int len2 = s2.length();
        if (len1 == 0 && len2 == 0) return 1.0;
        if (len1 == 0 || len2 == 0) return 0.0;

        int matchDistance = Math.max(len1, len2) / 2 - 1;
        boolean[] s1Matches = new boolean[len1];
        boolean[] s2Matches = new boolean[len2];

        int matches = 0;
        for (int i = 0; i < len1; i++) {
            int start = Math.max(0, i - matchDistance);
            int end = Math.min(i + matchDistance + 1, len2);
            for (int j = start; j < end; j++) {
                if (s2Matches[j]) continue;
                if (s1.charAt(i) == s2.charAt(j)) {
                    s1Matches[i] = true;
                    s2Matches[j] = true;
                    matches++;
                    break;
                }
            }
        }

        if (matches == 0) return 0.0;

        int transpositions = 0;
        int k = 0;
        for (int i = 0; i < len1; i++) {
            if (!s1Matches[i]) continue;
            while (!s2Matches[k]) k++;
            if (s1.charAt(i) != s2.charAt(k)) transpositions++;
            k++;
        }

        return (matches / (double) len1 + matches / (double) len2 + (matches - transpositions / 2.0) / matches) / 3.0;
    }

    private static void runTests() {
        String s1 = "MARTHA";
        String s2 = "MARHTA";
        double dist = jaroWinklerDistance(s1, s2);
        // Jaro for MARTHA/MARHTA:
        // matches = 6, transpositions = 2 (HT vs TH)
        // j = (6/6 + 6/6 + (6 - 1)/6) / 3 = (1 + 1 + 5/6) / 3 = 2.8333 / 3 = 0.9444
        // prefix = MAR (3)
        // jw = 0.9444 + 3 * 0.1 * (1 - 0.9444) = 0.9444 + 0.3 * 0.0556 = 0.9444 + 0.0167 = 0.9611
        if (Math.abs(dist - 0.9611) > 0.001) {
            throw new AssertionError("Test failed for MARTHA/MARHTA. Got " + dist);
        }

        s1 = "DWAYNE";
        s2 = "DUANE";
        dist = jaroWinklerDistance(s1, s2);
        // matches: D, A, N, E (4)
        // transpositions: 0
        // j = (4/6 + 4/5 + 4/4) / 3 = (0.666 + 0.8 + 1) / 3 = 2.466 / 3 = 0.822
        // prefix: D (1)
        // jw = 0.822 + 1 * 0.1 * (1 - 0.822) = 0.822 + 0.0178 = 0.840
        if (Math.abs(dist - 0.840) > 0.001) {
             throw new AssertionError("Test failed for DWAYNE/DUANE. Got " + dist);
        }

        System.out.println("ok - Challenge 010 Task 2 tests passed");
    }

    public static void main(String[] args) {
        if (args.length > 0 && "--test".equals(args[0])) {
            runTests();
            return;
        }

        if (args.length < 2) {
            System.out.println("Usage: java Challenge010Task2 <s1> <s2>");
            return;
        }

        System.out.println("Jaro-Winkler distance: " + jaroWinklerDistance(args[0], args[1]));
    }
}
