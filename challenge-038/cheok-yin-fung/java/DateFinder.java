// The Weekly Challenge - 038 
// Task 1 Date Finder
// attempt: May 09th, 2021
// from: C.-Y. Fung
// Usage: java DateFinder [7-digit string]

import java.time.LocalDate;
import java.time.YearMonth;

public class DateFinder
{
    public static void main(String[] args) 
    {
        String myYear = "", in_str = "";
        try {
            in_str = args[0];
            for (char numChar : in_str.toCharArray()) {
                if (numChar < '0' || numChar> '9') {
                    System.out.println("Non-numeric character found.");
                    throw new IllegalArgumentException();
                }
            }
            switch(in_str.charAt(0)) {
                case '1': myYear = "20"+in_str.substring(1,3); break;
                case '2': myYear = "19"+in_str.substring(1,3); break;
                default: throw new IllegalArgumentException();
            }
            if (in_str.length() != 7) { 
                System.out.println("Input digits is not equal to 7.");
                throw new IllegalArgumentException();
            }
        } catch (IllegalArgumentException e) {
            System.out.println("Ilegal argument.");
            System.exit(0);
        } catch (IndexOutOfBoundsException e) {
            System.out.println("Usage: java DateFinder [7-digit string]");
            System.exit(0);
        }

        String myMonth = in_str.substring(3,5);
        int myMonth_i = Integer.parseInt(myMonth);
        try {
            if (myMonth_i > 12 || myMonth_i < 1) 
                throw new IllegalArgumentException();
        } catch (IllegalArgumentException e) {
            System.out.println("Problem in Month (within 01-12) " + myMonth);
            System.exit(0);
        }
        String myDay = in_str.substring(5,7);
        int myDay_i = Integer.parseInt(myDay);
        int myYear_i = Integer.parseInt(myYear);
        try {
            YearMonth temp = YearMonth.of(myYear_i, myMonth_i);
            int daysInMonth = temp.lengthOfMonth();
            if (myDay_i > daysInMonth || myDay_i < 1) 
                throw new IllegalArgumentException();
        } catch (IllegalArgumentException e) {
            System.out.println("Problem in date (last two digits) " + myDay);
            System.exit(0);
        } finally {
            System.out.println(myYear + "-" + myMonth + "-" + myDay);        
        }
    }

}
