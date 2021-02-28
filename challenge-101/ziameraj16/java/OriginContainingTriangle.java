import java.util.Arrays;
import java.util.Scanner;

public class OriginContainingTriangle {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter first coordinates");
        int[] firstCoordinate = Arrays.stream(scanner.nextLine().split(",")).mapToInt(Integer::parseInt).toArray();
        System.out.println("Enter second coordinates");
        int[] secondCoordinate = Arrays.stream(scanner.nextLine().split(",")).mapToInt(Integer::parseInt).toArray();
        System.out.println("Enter third coordinates");
        int[] thirdCoordinate = Arrays.stream(scanner.nextLine().split(",")).mapToInt(Integer::parseInt).toArray();
        System.out.println("Output: " + doesTriangleContainsOrigin(firstCoordinate[0], firstCoordinate[1], secondCoordinate[0], secondCoordinate[1], thirdCoordinate[0], thirdCoordinate[1]));
    }

    public static int doesTriangleContainsOrigin(int x1, int y1, int x2, int y2, int x3, int y3) {
        double area = Math.abs((x1*(y2 - y3) + x2*(y3 - y1) + x3*(y1 - y2)) / 2.0);

        double area_1 = Math.abs((x2*y3 + x3*(-y2)) / 2.0);
        double area_2 = Math.abs((x1*(-y3) + x3*y1) / 2.0);
        double area_3 = Math.abs((x1*y2 + x2*(-y1)) / 2.0);

        double aumOfAreaOfSmallTriangles = area_1 + area_2 + area_3;
        return area == aumOfAreaOfSmallTriangles ? 1 : 0;
    }
}
