import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author mddicicco
 */
public class ch2 {
    static final double PRECISION = Math.pow(10,12);
    public static void main(String[] args){
        
        List<String> achilles_nums = new ArrayList<>();
        
        for(long i = 72; i < 1801; i++){
            if(isAchilles(primeFactors(i), i)){
                achilles_nums.add(Long.toString(i));
            }
        }
        System.out.println(String.join(", ", achilles_nums));
    }
    public static Boolean isAchilles(List<Long> factors, Long given){
        for(Long factor : factors){
            if(!(given % Math.pow(factor, 2) == 0))
                return false;
        }
        
        
       
        for(long i = 2; i <= 9; i++){
            double root = Math.round(nthRoot(given, i) * PRECISION)/PRECISION;
            
            if (Math.floor(root) == root){
                
                return false;
            }
        }
        return true;
                
    }
    public static double nthRoot(double someNumber, double n){
        return Math.pow(n, ((1.0 / n ) * (Math.log(someNumber) / Math.log(n))));
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
