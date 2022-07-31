import java.util.HashSet;
import java.util.ArrayList;

class PerfectTotient{

    private static double EPSILON = 1e-7;  

    private static ArrayList primeFactors(int n){
        ArrayList factors = new ArrayList();    
        while (n % 2 == 0){
            factors.add(new Integer(2));
            n = n / 2;
        }
        for(int i = 3; i <= Math.sqrt(n); i = i + 2){
            while (n % i == 0){
                factors.add(new Integer(i));
                n = n / i;
            }
        }
        if(n > 2)
            factors.add(new Integer(n));
        return factors;  
    }

    private static int totient(int n){
        ArrayList factors = new ArrayList();
        factors.addAll(new HashSet(primeFactors(n))); 
        float totient = n;
        for(int i = 0; i < factors.size(); i++){
            totient *= (1 - (1.0 / ((Integer) factors.get(i)).intValue()));  
        }  
        return (int) totient; 
    } 

    public static int[] perfectTotients(int n){
        int[] perfectTotients = new int[n];
        int i = 0; 
        int x = 1;
        while(i < n){
            x++;
            ArrayList totients = new ArrayList(); 
            int totient = totient(x);
            totients.add(new Integer(totient)); 
            while(Math.abs(totient - 1) > EPSILON){   
                totient = totient(totient); 
                totients.add(new Integer(totient)); 
            }
            int totientSum = 0;
            for(int j = 0; j < totients.size(); j++)
                totientSum += ((Integer)totients.get(j)).intValue();
            if(totientSum == x){
                perfectTotients[i] = x;
                i++; 
            }  
        } 
        return perfectTotients;  
    } 

    public static void main(String[] args){
        int[] perfectTotients = perfectTotients(20);
        for(int i = 0; i < perfectTotients.length - 1; i++)
            System.out.print(perfectTotients[i] + ", ");    
        System.out.println(perfectTotients[perfectTotients.length - 1]);  
    }   
}
