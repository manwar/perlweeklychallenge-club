public class DisariumNumbers {

    public static void main(String... args) {
        int i = 1;
        for (long j = 0; i <= 19; j++) {
            if (isDisarium(j)) {
                System.out.println(i + ": " + j);
                i++;
            }
        }
    }

    private static boolean isDisarium(long num) {
        long myNum = num;
        long sum = 0;
        int remainder;
        int pow = String.valueOf(num).length();
        while (num > 0) {
            remainder = (int) num % 10;
            sum = sum + (int) Math.pow(remainder, pow);
            num = num / 10;
            pow--;
        }
        if (myNum == sum) {
            return true;
        } else {
            return false;
        }
    }

}
