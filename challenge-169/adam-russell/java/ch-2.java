import java.util.ArrayList;

class Achilles{
    private static final double EPSILON = 1e-15;
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
    
    private static boolean isAchilles(int n){
        ArrayList factors = primeFactors(n);
        for(int i = 0; i < factors.size(); i++){
            if(n % Math.pow(((Long)factors.get(i)).longValue() + 0.0, 2) != 0)
                return false;
        }
        for(int i = 2; i <= Math.sqrt(n); i++) {
            double d = Math.log(n) / Math.log(i);
            if(Math.abs(d - Math.round(d)) < EPSILON)
                return false; 
        }
        return true;
    }
    
    public static ArrayList nAchilles(int n){
        ArrayList achilles = new ArrayList();
        int i = 1;
        do{
            i++;
            if(isAchilles(i))
                achilles.add(new Integer(i));
        }while(achilles.size() < n);
        return achilles;
    }

    public static void main(String[] args){        
        ArrayList achilles = Achilles.nAchilles(20);
        for(int i = 0; i < achilles.size() - 1; i++){
            System.out.print(achilles.get(i) + ", ");
        }
        System.out.println(achilles.get(achilles.size() - 1));
    }
}