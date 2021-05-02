// The Weekly Challenge 110
// Task 1 Valid Phone Numbers

import java.io.File;
import java.util.Scanner;
import java.io.FileNotFoundException;

// Usage: java PhoneNumber [file name]

public class PhoneNumber
{
    public static void main(String[] args) throws Exception 
    {
        try { 
            File file = new File(args[0]);
            Scanner sc = new Scanner(file);
            while (sc.hasNextLine()) {
                String num = sc.nextLine();
                if ( checkHead(num) && checkMid(num) &&
                     num.substring(5).trim().length() == 10 && checkTail(num))
                    System.out.println(num);
            }
        } catch (FileNotFoundException e) {
            System.out.println(e.getMessage());
            System.exit(0);
        } catch (IndexOutOfBoundsException e) {
            System.out.println("Usage: java PhoneNumber [file name]");
            System.exit(0);
        }
    }

    private static boolean checkHead(String tel)
    {
        tel = tel.trim();
        if (tel.charAt(0) == '+' 
            && isNumeric(tel.charAt(1))
            && isNumeric(tel.charAt(2)) )
             return true;
        
        if (tel.charAt(0) == '(' && tel.charAt(3) == ')'
            && isNumeric(tel.charAt(1))
            && isNumeric(tel.charAt(2)))
             return true;

        boolean temp_bl = true;
        for (int a = 0; a < 4 && temp_bl ; a++) 
            temp_bl = temp_bl && isNumeric(tel.charAt(a));
        return temp_bl;
    }

    private static boolean checkMid(String tel)
    {
        return tel.charAt(4) == ' ';
    }

    private static boolean checkTail(String tel)
    {
        boolean temp_bl = true;
        for (int i = 0; i < 10  && temp_bl ; i++) 
            temp_bl = temp_bl && isNumeric(tel.charAt(5+i));
        return temp_bl;
    }

    private static boolean isNumeric(char ch)
    {
        if (ch >= '0' && ch <= '9') return true;
        else return false;
    }

}
