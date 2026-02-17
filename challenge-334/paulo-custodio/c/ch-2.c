#include "alloc.h"

typedef struct {
    int x, y;
} Point;

bool read_point(Point* p) {
    char line[BUFSIZ];
    if (!fgets(line, sizeof(line), stdin))
        return false;
    if (sscanf(line, "%d %d", &p->x, &p->y) != 2)
        return false;

    return true;
}

int manhatan_dist(Point* a, Point* b) {
    return abs(a->x - b->x) + abs(a->y - b->y);
}

int minimum_distance() {
    int min_dist = -1;
    int min_index = -1;

    Point p;
    if (!read_point(&p))
        return -1;

    Point a;
    int i = -1;
    while (read_point(&a)) {
        i++;
        if (a.x != p.x && a.y != p.y)
            continue;

        int dist = manhatan_dist(&p, &a);
        if (min_dist == -1 || dist < min_dist) {
            min_dist = dist;
            min_index = i;
        }
    }
    return min_index;
}

int main() {
    int dist = minimum_distance();
    printf("%d\n", dist);
}
