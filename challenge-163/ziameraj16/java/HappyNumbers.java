import java.util.ArrayList;
import java.util.List;

public class HappyNumbers {

    public static void main(String[] args) {
        int c = 0;
        for (int i = 0; c < 8; i++) {
            if (isHappyNumber(i)) {
                System.out.println(i);
                c++;
            }
        }
    }

    private static boolean isHappyNumber(int i) {
        List<Integer> list = new ArrayList();
        while(i > 0) {
            list.add(i % 10);
            i = i / 10;
        }
        int sum = 0;
        for (int j : list) {
            sum = sum + j*j;
        }
        if (sum == 1) {
            return true;
        } else if (sum < 10) {
            return false;
        } else {
            isHappyNumber(sum);
        }
        return false;
    }
}
