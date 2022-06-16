import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author mddicicco
 */
public class ch1 {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        List<String> brilliants = new ArrayList<>();
        for (long i = 4L; i < 300L; i++) {
            if (isBrilliant(primeFactors(i))){
                brilliants.add(Long.toString(i)); 
            }
        }
        System.out.println(String.join(", ", brilliants));
    }

    public static Boolean isBrilliant(List<Long> factors) {
        return (factors.size() == 2 && factors.get(0).toString().length() == factors.get(1).toString().length());
    }

    public static List<Long> primeFactors(long n) {
        List<Long> output = new ArrayList<>();

        // Print the number of 2s that divide n
        while (n % 2L == 0L) {
            output.add(2L);
            n /= 2L;
        }

        // n must be odd at this point.  So we can
        // skip one element (Note i = i +2)
        for (long i = 3L; i <= Math.sqrt(n); i += 2L) {
            // While i divides n, print i and divide n
            while (n % i == 0) {
                output.add(i);
                n /= i;
            }
        }

        // This condition is to handle the case when
        // n is a prime number greater than 2
        if (n > 2L) {
            output.add(n);
        }
        return output;
    }

}
