// To run:
// $ java ch-1.java 100
// 13015

class Main {
    static int gcd(int a, int b) {
        while (b != 0) {
            int t = b;
            b = a % b;
            a = t;
        }

        return a;
    }

    public static void main(String[] args) {
        int n = args.length == 1 ? Integer.parseInt(args[0]) : 3;

        int s = 0;
        for (int x = 1; x <= n; x++) {
            for (int y = x + 1; y <= n; y++) {

                s += gcd(x, y);
            }
        }

        System.out.println(s);
    }
}
