import java.util.Scanner;

public class EditDistance {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter first word");
        String s1 = scanner.next();
        System.out.println("Enter second word");
        String s2 = scanner.next();
        System.out.println("Output: "+ editDistance(s1, s2));
    }

    private static int editDistance(String s1, String s2) {
        int len = s1.length();
        if (s2.length() < s1.length()) {
            len = s2.length();
        }
        int count = 0;
        for (int i = 0; i < len; i++) {
            if (s1.charAt(i) != s2.charAt(i)) {
                count++;
            }
        }
        return count + Math.abs(s1.length() - s2.length());
    }
}
