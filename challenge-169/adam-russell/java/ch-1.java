import java.util.ArrayList;

class Brilliant{
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
    
    private static boolean isBrilliant(int n){
        ArrayList factors = primeFactors(n);
        return factors.size() == 2 && ((Long)factors.get(0)).toString().length() == ((Long)factors.get(1)).toString().length();
    }
    
    public static ArrayList nBrilliants(int n){
        ArrayList brilliants = new ArrayList();
        int i = 0;
        do{
            i++;
            if(isBrilliant(i))
                brilliants.add(new Integer(i));
        }while(brilliants.size() < n);
        return brilliants;
    }

    public static void main(String[] args){        
        ArrayList brilliants = Brilliant.nBrilliants(20);
        for(int i = 0; i < brilliants.size() - 1; i++){
            System.out.print(brilliants.get(i) + ", ");
        }
        System.out.println(brilliants.get(brilliants.size() - 1));
    }
}