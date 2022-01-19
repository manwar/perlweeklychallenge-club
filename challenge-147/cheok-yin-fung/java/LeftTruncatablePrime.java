// The Weekly Challenge 147
// Task 1 Truncatable Prime
// Friday, January 14, 2022 AM11:26:14 HKT
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Arrays;
@SuppressWarnings("unchecked")

public class LeftTruncatablePrime
{
    public static List<Integer> Primes;
    public static List<Integer> LTPrimes;
    public static List<Integer> recentLTPrimes;
    public static List<Integer> newLTPrimes;

    public static void main(String... args) 
    {
        Integer[] singleDigitPrimes = {2, 3, 5, 7};
        Primes = new ArrayList<Integer>();
        Collections.addAll(Primes, singleDigitPrimes);

        LTPrimes = new ArrayList<Integer>();
        recentLTPrimes = new ArrayList<Integer>();
        Collections.addAll(recentLTPrimes, singleDigitPrimes);
        newLTPrimes = new ArrayList<Integer>();
        appendPrimes(1000);
        appendLTPrimes(20);
        
        for (int i = 0; i < 20; i++)
            System.out.println(LTPrimes.get(i));
    }

    public static boolean isPrime(Integer x)
    {
        Integer p = 0;
        for (int i = 0; p <= Math.sqrt(x) ; i++ )
        {
            p = Primes.get(i);
            if (x % p == 0) 
                return false;
        } 
        return true;
    }

    public static void appendPrimes(Integer max)
    {
        Integer i = Primes.get(Primes.size()-1)+1;
        while (Primes.get(Primes.size()-1) < max)
        {
            if (isPrime(i))
                Primes.add(i);
            i++;
        }
    }


    public static void appendLTPrimes(Integer targetSize)
    {
        if (targetSize <= LTPrimes.size() + recentLTPrimes.size())
        {
            LTPrimes.addAll(recentLTPrimes);
            return;
        }
        for (int d = 1; d <= 9; d++) {
            for (Integer num : recentLTPrimes)
            {
                int newNum = Integer.parseInt(d + "" + num);
                if (isPrime(newNum)) {
                    newLTPrimes.add(newNum);
                }
            }
        }
        LTPrimes.addAll(recentLTPrimes);
        recentLTPrimes = (List)((ArrayList)newLTPrimes).clone();
        newLTPrimes.clear();
        appendLTPrimes(targetSize);
    }
}
