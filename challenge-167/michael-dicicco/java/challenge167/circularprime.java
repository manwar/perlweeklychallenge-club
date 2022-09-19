package challenge167;

import java.util.LinkedHashSet;
import java.util.Set;

/**
 *
 * @author mddicicco
 */
public class circularprime {
    public static Set<String> used_numbers = new LinkedHashSet<>();
    public static boolean isPrime(int someNumber){
        if (someNumber <= 1){
            return false;
        }
        for(int i = 2; i < (someNumber - 1); i++){
            if (someNumber % i == 0){
                return false;
            }
        }
        return true;
    }
    
    public static String rotate(String someNumber){
        // rotate to the left one character
        return someNumber.substring(1,someNumber.length()) + someNumber.substring(0,1);
    }
    
    public static boolean validate(String someNumber){
        // check if the original string is prime
        if (!isPrime(Integer.parseInt(someNumber))){
            return false;
        }
        
        String temp = someNumber;
        // check if any rotations of the string are not prime
        for(int i = 0; i < someNumber.length() - 1; i++){
            temp = rotate(temp);
            if (!isPrime(Integer.parseInt(temp))){
                return false;
            }
            used_numbers.add(temp);
        }
        return true;
    }
}
