class Main {
    public static void main(String args[]) {
        double input = Double.parseDouble(args[0]);
        for (int i = 1; i <= 10; i++) {
            double root = Math.pow(input, 1.0 / i );
            System.out.format("%2d   %10.3f\n", i, root);
        }
    }
}
