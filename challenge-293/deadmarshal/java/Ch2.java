public class Ch2 {
  record Point(int x, int y) {}
  
  public static void main(String[] args) {
    Point[] a1 = new Point[]{new Point(1, 1), new Point(2, 3), new Point(3, 2)};
    Point[] a2 = new Point[]{new Point(1, 1), new Point(2, 2), new Point(3, 3)};
    Point[] a3 = new Point[]{new Point(1, 1), new Point(1, 2), new Point(2, 3)};
    Point[] a4 = new Point[]{new Point(1, 1), new Point(1, 2), new Point(1, 3)};
    Point[] a5 = new Point[]{new Point(1, 1), new Point(2, 1), new Point(3, 1)};
    Point[] a6 = new Point[]{new Point(0, 0), new Point(2, 3), new Point(4, 5)};
    System.out.println(boomerang(a1));
    System.out.println(boomerang(a2));
    System.out.println(boomerang(a3));
    System.out.println(boomerang(a4));
    System.out.println(boomerang(a5));
    System.out.println(boomerang(a6));
  }

  private static boolean boomerang(Point[] a) {
    return (a[1].y - a[0].y) * (a[2].x - a[1].x) !=
      (a[2].y - a[1].y) * (a[1].x - a[0].x);
  }
}

