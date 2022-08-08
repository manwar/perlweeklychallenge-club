public class ReversibleNumbers {

    public static int reverse(int n) {
        String n_str = String.valueOf(n);
        String rev = "";
        char ch;
        for (int i = 0; i < n_str.length(); i++) {
            ch = n_str.charAt(i);   //extracts each character
            rev = ch + rev;         //adds each character in front of the existing string
        }
        return Integer.parseInt(rev);
    }

    public static boolean isReversible(int n) {
        int sum = n + reverse(n);
        char[] digits = String.valueOf(sum).toCharArray();
        for (int i = 0; i < digits.length; i++) {
            if ((digits[i] - '0') % 2 == 0) {
                return false;
            }
        }
        return true;
    }

    public static void main(String[] args) {
        for (int i = 1; i <= 100; i++) {
            if (isReversible(i)) {
                System.out.printf("%d ", i);
            }
        }
        System.out.printf("%s", "\n");
    }
}
