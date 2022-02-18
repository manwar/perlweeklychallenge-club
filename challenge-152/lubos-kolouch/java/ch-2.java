class Point {
  int x, y;

  public Point(int x, int y) {
    this.x = x;
    this.y = y;
  }
};

class Rectangle {
  Point left, right;

  public Rectangle(Point left, Point right) {
    this.left = left;
    this.right = right;
  }

  public int get_area() {
    return Math.abs(this.left.x - this.right.x) *
        Math.abs(this.left.y - this.right.y);
  }
};

class OverlapArea {

  static int get_total_area(Rectangle first, Rectangle second) {
    int area1 = first.get_area();
    int area2 = second.get_area();

    // calculate the overlapping area
    int x_dist = Math.min(first.right.x, second.right.x) -
                 Math.max(first.left.x, second.left.x);
    int y_dist = Math.min(first.right.y, second.right.y) -
                 Math.max(first.left.y, second.left.y);
    int areaI = 0;
    if (x_dist > 0 && y_dist > 0) {
      areaI = x_dist * y_dist;
    }

    return (area1 + area2 - areaI);
  }

  public static void main(String[] args) {
    Rectangle first = new Rectangle(new Point(-1, 0), new Point(2, 2));
    Rectangle second = new Rectangle(new Point(0, -1), new Point(4, 4));

    if (get_total_area(first, second) != 22) {
      System.out.println("Failed test 1");
    }

    first = new Rectangle(new Point(-3, -1), new Point(1, 3));
    second = new Rectangle(new Point(-1, -3), new Point(2, 2));

    if (get_total_area(first, second) != 25) {
      System.out.println("Failed test 2");
    }
  }
}
