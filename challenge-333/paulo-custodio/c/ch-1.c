#include "alloc.h"

typedef struct {
    int x, y;
} Point;

bool are_colinear(Point* p1, Point* p2, Point* p3) {
    int double_area =  p1->x * (p2->y - p3->y) +
                       p2->x * (p3->y - p1->y) +
                       p3->x * (p1->y - p2->y);

    return double_area == 0 ? true : false;
}

int main(int argc, char* argv[]) {
    if (argc != 7)
        die("usage: %s x1 y1 x2 y2 x3 y3\n", argv[0]);

    Point p1, p2, p3;
    p1.x = atoi(argv[1]);
    p1.y = atoi(argv[2]);
    p2.x = atoi(argv[3]);
    p2.y = atoi(argv[4]);
    p3.x = atoi(argv[5]);
    p3.y = atoi(argv[6]);

    bool colinear = are_colinear(&p1, &p2, &p3);
    printf("%s\n", colinear ? "true" : "false");
}
