import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;

/**
 * Perl Weekly Challenge 004 - Task 1.
 * Print PI with as many characters as the size of this script in bytes.
 */
class Challenge004Task1 {
    private static final String PI_DIGITS =
        "3.14159265358979323846264338327950288419716939937510"
        + "58209749445923078164062862089986280348253421170679"
        + "82148086513282306647093844609550582231725359408128";

    private static String piPrefix(int size) {
        int length = size + 1; // include decimal point
        return PI_DIGITS.substring(0, Math.min(length, PI_DIGITS.length()));
    }

    private static void runTests() {
        String got = piPrefix(10);
        if (!"3.141592653".equals(got)) {
            throw new AssertionError("Expected 3.141592653, got " + got);
        }
        System.out.println("ok - challenge 004 task 1 tests passed");
    }

    public static void main(String[] args) throws IOException {
        if (args.length > 0 && "--test".equals(args[0])) {
            runTests();
            return;
        }

        int scriptSize = Files.readAllBytes(Paths.get("challenge-004/lubos-kolouch/java/ch-1.java")).length;
        System.out.println(piPrefix(scriptSize));
    }
}
