import std::io;

extern func float strtof(char* str, char** str_end);

struct Point {
    float x, y;
}

func void Point.add(Point *a, Point b) {
    a.x += b.x;
    a.y += b.y;
}

func void Point.sub(Point *a, Point b) {
    a.x -= b.x;
    a.y -= b.y;
}

macro abs(x) {
    return x < 0 ? -x : x;
}

const float EPSILON = 0.00001;

macro bool eq(a, b) {
    return @abs(a - b) < EPSILON;
}

func bool Point.eq(Point *a, Point b) {
    return @eq(a.x, b.x) && @eq(a.y, b.y);
}

func int main(int argc, char** argv) {
    if (argc != 9) return 1;

    Point[4] pts = void;
    for (int i; i < 8; i++) {
        (*(float[8]*)(&pts))[i] = strtof(argv[i + 1], null);
    }

    Point center;
    foreach (p : pts) center.add(p);
    center.x /= 4;
    center.y /= 4;

    Point[4] v = void;
    v[0] = pts[0];
    v[0].sub(center);
    v[1] = { v[0].x, -v[0].y };
    v[2] = { -v[0].x, v[0].y };
    v[3] = { -v[0].x, -v[0].y };

    foreach (&x : v) x.add(center);

    bool square = {|
        for FOUND: (int i; i < 4; i++) {
            for (int j; j < 4; j++) {
                if (v[i].eq(pts[j])) continue FOUND;
            }
            return false;
        }
        return true;
    |};

    io::printf("%d\n", square);

    return 0;
}
