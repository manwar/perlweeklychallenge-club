import java.util.*;

public class DemoStack {

    private static Scanner scanner = new Scanner(System.in);

    private static final int MAX_SIZE = 1000;
    int arr[] = new int[MAX_SIZE];
    int top = -1;

    public static void main(String[] args) {
        DemoStack demoStack = new DemoStack();
        System.out.println("Stack Example");
        while (true) {
            iterate(demoStack);
        }
    }

    private static void iterate(DemoStack demoStack) {
        System.out.println(String.join("\n",
                "\n####################################",
                "To push into stack - `push <number>`",
                "To pop from the stack - `pop`",
                "To find the top element - `top`",
                "To find the minimum element - `min`",
                "To exit - `exit`",
                "####################################\n"));

        final String[] options = scanner.nextLine().toLowerCase().split(" ");
        if (options[0].equals("push")) {
            demoStack.push(Integer.parseInt(options[1]));
        } else if (options[0].equals("pop")) {
            demoStack.pop();
        } else if (options[0].equals("top")) {
            demoStack.top();
        } else if (options[0].equals("min")) {
            demoStack.min();
        } else if (options[0].equals("exit")) {
            System.out.println("Bye!!!");
            System.exit(1);
        } else {
            System.out.println("Invalid option: " + options[0]);
        }
    }

    public boolean push(int number) {
        if (top == MAX_SIZE - 1) {
            System.err.println("Stack is full");
            return false;
        }
        arr[++top] = number;
        System.out.println(String.format("Number %s added to the stack", number));
        return true;
    }

    public int pop() {
        if (top < 0) {
            System.err.println("No element to pop");
            return Integer.MIN_VALUE;
        }
        int num = arr[top--];
        System.out.println("Element popped: " + num);
        return num;
    }

    public int top() {
        if (top < 0) {
            System.err.println("Stack is empty");
            return Integer.MIN_VALUE;
        }
        int num = arr[top];
        System.out.println("Top element: " + num);
        return num;
    }

    public int min() {
        if (top < 0) {
            System.err.println("Stack is empty");
            return Integer.MIN_VALUE;
        }
        final int[] copyArr = Arrays.copyOf(arr, top + 1);
        Arrays.sort(copyArr);
        int min =  copyArr[0];
        System.out.println("Minimum number in stack: " + min);
        return min;
    }
}

