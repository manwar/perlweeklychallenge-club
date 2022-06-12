import java.util.Random;
import java.util.ArrayList;
import java.math.BigInteger;
import java.util.Collections;
  
/** Class MillerRabin **/
/* Slightly modified version of code taken from 
   https://www.sanfoundry.com/java-program-miller-rabin-primality-test-algorithm/ */
class MillerRabin{
    private static final int ITERATIONS = 7;
    /** Function to check if prime or not **/
    public static boolean isPrime(long n){
        /** base case **/
        if (n == 0 || n == 1)
            return false;
        /** base case - 2 is prime **/
        if (n == 2)
            return true;
        /** an even number other than 2 is composite **/
        if (n % 2 == 0)
            return false;
        long s = n - 1;
        while (s % 2 == 0)
            s /= 2;
        Random rand = new Random();
        for (int i = 0; i < ITERATIONS; i++){
            long r = Math.abs(rand.nextLong());            
            long a = r % (n - 1) + 1, temp = s;
            long mod = modPow(a, temp, n);
            while (temp != n - 1 && mod != 1 && mod != n - 1){
                mod = mulMod(mod, mod, n);
                temp *= 2;
            }
            if (mod != n - 1 && temp % 2 == 0)
                return false;
        }
        return true;        
    }
    /** Function to calculate (a ^ b) % c **/
    public static long modPow(long a, long b, long c){
        long res = 1;
        for (int i = 0; i < b; i++){
            res *= a;
            res %= c; 
        }
        return res % c;
    }
    /** Function to calculate (a * b) % c **/
    public static long mulMod(long a, long b, long mod){
        return BigInteger.valueOf(a).multiply(BigInteger.valueOf(b)).mod(BigInteger.valueOf(mod)).longValue();
    }
}

class HomePrime{
    private static ArrayList primeFactors(long n){
        ArrayList factors = new ArrayList();    
        while (n % 2 == 0){
            factors.add(new Long(2));
            n = n / 2;
        }
        for(long i = 3; i <= Math.sqrt(n); i = i + 2){
            while (n % i == 0){
                factors.add(new Long(i));
                n = n / i;
            }
        }
        if(n > 2)
            factors.add(new Long(n));
        return factors;  
    }
    
    public static long homePrime(long n){
        ArrayList primeFactors = primeFactors(n);
        String s = "";
        for(int i = 0; i < primeFactors.size(); i++){
           s += ((Long) primeFactors.get(i)).toString();
        }
        if(MillerRabin.isPrime(Long.valueOf(s).longValue())){
            return Long.valueOf(s).longValue();
        }
        return homePrime(Long.valueOf(s).longValue());
    }

    public static void main(String[] args){        
        System.out.println(HomePrime.homePrime(10));
        System.out.println(HomePrime.homePrime(16));
        System.out.println(HomePrime.homePrime(48));
    }
}