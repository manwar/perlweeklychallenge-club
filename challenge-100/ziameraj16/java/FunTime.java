import java.util.Scanner;

public class FunTime {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter time");
        String time = scanner.nextLine();
        System.out.println("Output: " + convertTime(time));
    }

    public static String convertTime(String time) {
        if (time.contains("am") || time.contains("pm")) {
            if (time.startsWith("12")) {
                if (time.contains("am")) {
                    return String.format("%s:%s","00", time.substring(3, 5));
                } else {
                    return String.format("%s:%s","12", time.substring(3, 5));
                }
            }
            return String.format("%s:%s",Integer.parseInt(time.substring(0, 2)) + 12, time.substring(3, 5));
        } else {
            final int hour = Integer.parseInt(time.substring(0, 2));
            String amOrPm = Integer.parseInt(time.substring(0, 2)) >= 12 ? "pm" : "am";
            if (hour == 0 || hour > 12) {
                return String.format("%02d:%s%s", Math.abs(hour - 12), time.substring(3, 5), amOrPm);
            } else {
                return String.format("%02d:%s%s", hour, time.substring(3, 5), amOrPm);
            }

        }
    }
}
