// The Weekly Challenge - 109
// Task 2 Four Squares(Rectangles) Puzzle
// Supporting codes

class Box
{
    private Point tl, br;

    Box(int x1, int y1, int x2, int y2) {
        tl = new Point(x1, y1);
        br = new Point(x2, y2);
    }

    Box(Point p1, Point p2) {
        this(p1.x(), p1.y(), p2.x(), p2.y());
    }

    Point topLeft() {
        return tl;
    }

    int height() {
        return br.x()-tl.x();
    }

    int width() {
        return br.y()-tl.y();
    }

    boolean isEnclosed(Point p) {
        return p.x() > tl.x() && p.x() < br.x() &&
               p.y() > tl.y() && p.y() < br.y();
    }
}
