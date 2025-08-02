// java java/ch-2.java
import java.util.List;
import java.util.stream.IntStream;
import java.util.stream.Collectors;
public class ch_2 {


    static int task2 ( Integer k, List<Integer> ns ) {
        Integer[] ints = ns.toArray(new Integer[0]);

        return IntStream.range(0, ints.length)
            .filter(i -> Integer.bitCount(i) == k)
            .mapToObj(i -> ints[i])
            .collect(Collectors.summingInt(Integer::intValue));
    }



    // Test harness
    static int test_number = 1;
    static void  plan ( Integer count ) { System.out.printf("1..%d\n", count); }
    static boolean is ( Integer got, Integer expected, String desc ) {
        boolean ret = got == expected;
        System.out.printf("%s %d - %s\n", (ret ? "ok" : "not ok"), test_number++, desc);
        return ret;
    }
    public static void main(String[] args) {
        record Testcase ( Integer expected, Integer in_k, List<Integer> in_nums ) {}

        List<Testcase> tst = List.of(
            new Testcase( 17, 1, List.of(2, 5, 9, 11, 3) ),
            new Testcase( 11, 2, List.of(2, 5, 9, 11, 3) ),
            new Testcase(  2, 0, List.of(2, 5, 9, 11, 3) )
        );
        plan(tst.size());
        for (Testcase t : tst) {
            is( task2(t.in_k, t.in_nums), t.expected, "k=" + t.in_k);
        }

    }
}
