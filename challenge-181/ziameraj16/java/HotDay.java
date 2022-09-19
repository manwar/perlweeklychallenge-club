import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.*;

public class HotDay {

    public static void main(String[] args) throws IOException {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter absolute file path");
        String file = scanner.nextLine();
        List<Value> list = new ArrayList<>();
        try (BufferedReader br = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] values = line.split(",");
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                LocalDate date = LocalDate.parse(values[0], formatter);
                int temp = Integer.parseInt(values[1].trim());
                list.add(new Value(date, temp));
            }
        }
        Collections.sort(list, (o1, o2) -> o1.date.isAfter(o2.date) ? 1 : -1);
        for (int i = 0; i < list.size() - 1; i++) {
            if (list.get(i+1).temp > list.get(i).temp) {
                System.out.println(list.get(i+1).date.toString());
            }
        }
    }

    static class Value {
        public LocalDate date;
        public int temp;

        public Value(LocalDate date, int temp) {
            this.date = date;
            this.temp = temp;
        }

        @Override
        public String toString() {
            return  date.toString() + ":" + temp ;
        }
    }
}
