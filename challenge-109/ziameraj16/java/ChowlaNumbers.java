public class ChowlaNumbers {

    public static void main(String[] args) {
        displayChowlaNumbers(20);
    }

    private static void displayChowlaNumbers(int howMany) {
        System.out.print("0");
        for (int i = 2; i <= howMany; i++) {
            int sum = 0;
            for (int j = 1; j <= i; j++) {
                if (i % j == 0) {
                    sum += j;
                }
            }
            System.out.print(", " + (sum - 1 - i));
        }
        System.out.println();
    }
}
