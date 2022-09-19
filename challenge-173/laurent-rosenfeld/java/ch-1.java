import java.lang.Math;

public class EstheticNumber {
    public static void main(String[] args) {
        Integer[] tests = {5456, 120, 121, 23456, 2346, 7654567, 765467};
        for (int i = 0; i <= 6; i++) {
            if (is_esthetic(tests[i])) {
                System.out.printf("%-9d is esthetic\n", tests[i]);
            } else {
                System.out.printf("%-9d is not esthetic\n", tests[i]);
            }
        }
    }
    public static boolean is_esthetic(int n) {
        String s = Integer.toString(n);
        for (int i = 1; i < s.length(); i++ ) {
            if (Math.abs((int)(s.charAt(i)) - (int)(s.charAt(i-1))) != 1) {
                return false;
            }
        }
        return true;
    }
}
