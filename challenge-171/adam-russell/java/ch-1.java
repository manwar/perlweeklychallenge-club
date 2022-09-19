import java.util.ArrayList;

class Abundant{
    private static ArrayList properDivisors(int n){
        ArrayList divisors = new ArrayList();
        for(int i = 1; i < n / 2; i++){
            if(n % i == 0){
                divisors.add(new Integer(i));   
            }
        }
        return divisors;
    }
    
    public static ArrayList nAbundantsOdd(int n){
        ArrayList abundants = new ArrayList();
        int x = 1;
        do{
            x++;
            if(x % 2 == 1){
                ArrayList divisors = properDivisors(x);
                int sum = 0;
                for(int i = 0; i < divisors.size(); i++)
                    sum += ((Integer)divisors.get(i)).intValue();
                if(sum > x)
                    abundants.add(new Integer(x));
            }
        }while(abundants.size() < n);
        return abundants;
    }

    public static void main(String[] args){
        ArrayList abundants = Abundant.nAbundantsOdd(20);
        for(int i = 0; i < abundants.size() - 1; i++)
            System.out.print((Integer)abundants.get(i) + ", ");
        System.out.println((Integer)abundants.get(abundants.size() - 1));
    }
}