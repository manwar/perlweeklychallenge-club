public class Main {
    public static void main(String[] args) {
        int N = 4;
        ArrayList<String> grayCode = new ArrayList<>();
        grayCode.add("0");
        grayCode.add("1");

        for (int i = 2; i <= N; i++) {
            ArrayList<String> revGrayCode = new ArrayList<>(grayCode);
            Collections.reverse(revGrayCode);
            for (int j = 0; j < grayCode.size(); j++) {
                grayCode.set(j, "0" + grayCode.get(j));
            }
            for (int j = 0; j < revGrayCode.size(); j++) {
                revGrayCode.set(j, "1" + revGrayCode.get(j));
            }
            grayCode.addAll(revGrayCode);
        }

        for (String x : grayCode) {
            System.out.print(Integer.parseInt(x, 2) + " ");
        }
        System.out.println();
    }
}
