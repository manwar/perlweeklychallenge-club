// java java/ch-1.java
import java.util.List;
public class ch_1 {


    static long task1 ( List<Integer> ns ) {
        return ns.stream()
                 .filter(n -> n.toString().length() % 2 == 0)
                 .count();
    }


    // Test harness
    static int test_number = 1;
    static void  plan ( Integer count ) { System.out.printf("1..%d\n", count); }
    static boolean is ( long got, long expected, String desc ) {
        boolean ret = got == expected;
        System.out.printf("%s %d - %s\n", (ret ? "ok" : "not ok"), test_number++, desc);
        return ret;
    }
    public static void main(String[] args) {
        record Testcase ( int expected, List<Integer> inputs ) {}

        List<Testcase> tst = List.of(
            new Testcase( 3, List.of(  10, 1,   111,  24, 1000 ) ),
            new Testcase( 0, List.of( 111, 1, 11111            ) ),
            new Testcase( 1, List.of(   2, 8,  1024, 256       ) )
        );
        plan(tst.size());
        for (Testcase t : tst) {
            is( task1(t.inputs), t.expected, t.inputs.toString() );
        }
    }
}
