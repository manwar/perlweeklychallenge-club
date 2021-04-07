import java.lang.reflect.Method;
import java.util.Arrays;
import java.util.Scanner;

public class ListMethods {

    public static void main(String[] args) throws ClassNotFoundException {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter class name with package - e.g. 'java.util.List'");
        String clazzName = scanner.next();
        final Class<?> aClass = Class.forName(clazzName);
        final Method[] declaredMethods = aClass.getDeclaredMethods();
        Arrays.stream(declaredMethods).forEach(m -> System.out.println(m.getName()));
    }
}
