/**
 * Perl Weekly Challenge 011 - Task 1.
 * Fahrenheit and Celsius scales equal point.
 */
public class Challenge011Task1 {

    public static void main(String[] args) {
        for (int fahrenheit = -100; fahrenheit <= 212; fahrenheit++) {
            double celsius = (fahrenheit - 32.0) * 5.0 / 9.0;
            if (fahrenheit == (int) celsius && (fahrenheit - 32.0) * 5.0 % 9.0 == 0) {
                System.out.println("The equal point in the Fahrenheit and Celsius scales is " + fahrenheit + " °F and " + (int) celsius + " °C.");
                break;
            }
        }
    }
}
