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

class PerrinPrimes{
    private static ArrayList nPerrinPrimesR(int n, ArrayList perrins, ArrayList perrinPrimes){
        if(perrinPrimes.size() == n){
            return perrinPrimes;
        }
        else{
            perrins.add(new Integer(((Integer)perrins.get(perrins.size() - 3)).intValue() + ((Integer)perrins.get(perrins.size() - 2)).intValue()));
            if(MillerRabin.isPrime(((Integer)perrins.get(perrins.size() - 1)).intValue()))
                perrinPrimes.add(perrins.get(perrins.size() - 1));
        }
        return nPerrinPrimesR(n, perrins, perrinPrimes);
    }
    
    public static ArrayList nPerrinPrimes(int n){
        ArrayList perrins = new ArrayList();
        perrins.add(new Integer(3));
        perrins.add(new Integer(0));
        perrins.add(new Integer(2));
        return nPerrinPrimesR(n, perrins, new ArrayList());
    }

    public static void main(String[] args){        
        ArrayList perrinPrimes = PerrinPrimes.nPerrinPrimes(13);
        Collections.sort(perrinPrimes);
        for(int i = 0; i < perrinPrimes.size() - 1; i++){
            System.out.print(perrinPrimes.get(i) + ", ");
        }
        System.out.println(perrinPrimes.get(perrinPrimes.size() - 1));
    }
}