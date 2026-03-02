#include "alloc.h"

typedef struct {
    int x;
    int y;
} Point;

Point point_parse(const char* str) {
    Point p;
    sscanf(str, "%d %d", &p.x, &p.y);
    return p;
}

int calc_double_area(Point p1, Point p2, Point p3) {
    return abs(p1.x*(p2.y-p3.y)+p2.x*(p3.y-p1.y)+p3.x*(p1.y-p2.y));
}

int main(int argc, char* argv[]) {
    if (argc != 4)
        die("usage: %s 'x1 y1' 'x2 y2' 'x3 y3'", argv[0]);

    Point p1 = point_parse(argv[1]);
    Point p2 = point_parse(argv[2]);
    Point p3 = point_parse(argv[3]);
    int double_area = calc_double_area(p1, p2, p3);
    bool is_boomerang = double_area > 0;
    printf("%s\n", bool_to_string(is_boomerang));
}
