public class PerfectTotient {

    static int[] cache = new int[10000];

    public static int gcd(int i, int j) {
        while (j != 0) {
            int temp = i % j;
            i = j;
            j = temp;
        }
        return i;
    }
    public static boolean isPerfectTotient(int n) {
        int tot = 0;
        for (int i = 1; i < n; i++) {
            if (gcd(n, i) == 1) {
                tot++;
            }
        }
        int sum = tot + cache[tot];
        cache[n] = sum;
        return n == sum;
    }

    public static void main(String[] args) {
        int i = 0;
        int count = 0;
        while (count < 20) {
            if (isPerfectTotient(i)) {
                System.out.printf("%d ", i);
                count++;
            }
            i++;
        }
        System.out.printf("%s", "\n");
    }
}
