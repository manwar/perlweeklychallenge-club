import java.util.List;
import java.util.ArrayList;

class Primorial{
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
    
    private static ArrayList nPrimes(int n){
        ArrayList primes = new ArrayList();
        primes.add(new Integer(1));
        if(n == 0)
            return primes;
        int i = 1;
        do{
            i++;
            if(primeFactors(i).size() == 1)
                primes.add(new Integer(i));
        }while(primes.size() < n);
        return primes;
    }
    
    public static ArrayList nPrimorials(int n){
        ArrayList primes = nPrimes(n);
        ArrayList primorials = new ArrayList();    
        for(int i = 0; i < n; i++){
            long primorial = 1;
            List l = primes.subList(0, i + 1);
            for(int j = 0; j < l.size(); j++)
                primorial *= ((Integer)l.get(j)).intValue();
            primorials.add(new Long(primorial));
        }
        return primorials;
    }
    
    public static void main(String[] args){
        ArrayList primorials = Primorial.nPrimorials(10);
        for(int i = 0; i < primorials.size(); i++)
            System.out.println("P(" + i + ") = " + primorials.get(i));
    }
}