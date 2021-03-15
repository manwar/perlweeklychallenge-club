/*
Challenge 101

TASK #2 › Origin-containing Triangle
Submitted by: Stuart Little
You are given three points in the plane, as a list of six co-ordinates:
A=(x1,y1), B=(x2,y2) and C=(x3,y3).

Write a script to find out if the triangle formed by the given three
co-ordinates contain origin (0,0).

Print 1 if found otherwise 0.
*/

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

typedef struct Point {
    double x, y;
} Point;

double sign(Point p1, Point p2, Point p3) {
    return (p1.x - p3.x) * (p2.y - p3.y)
        - (p2.x - p3.x) * (p1.y - p3.y);
}

int point_in_triangle(Point p0, Point p1, Point p2, Point p3) {
    double d1 = sign(p0, p1, p2);
    double d2 = sign(p0, p2, p3);
    double d3 = sign(p0, p3, p1);

    bool has_neg = (d1 < 0.0) || (d2 < 0.0) || (d3 < 0.0);
    bool has_pos = (d1 > 0.0) || (d2 > 0.0) || (d3 > 0.0);

    if (!(has_neg && has_pos))
        return 1;
    else
        return 0;
}

int main(int argc, char* argv[]) {
    if (argc != 7) {
        fputs("Usage: ch-2 x1 y1 x2 y2 x3 y3", stderr);
        exit(EXIT_FAILURE);
    }
    else {
        Point p[3], p0;
        for (int i = 0; i < 3; i++) {
            p[i].x = atof(argv[i * 2 + 1]);
            p[i].y = atof(argv[i * 2 + 2]);
        }
        p0.x = p0.y = 0.0;
        printf("%d\n", point_in_triangle(p0, p[0], p[1], p[2]));
    }
}
