// Perl Weekly Challenge 165 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-165/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

#define WIDTH  500
#define HEIGHT 500

typedef struct {
    int x, y;
} Point;

typedef struct {
    Point* data;
    int size;
    int capacity;
} Points;

Points* points_new() {
    int capacity = 8;
    Points* points = xmalloc(sizeof(Points));
    points->data = xmalloc(capacity * sizeof(Point));
    points->size = 0;
    points->capacity = capacity;
    return points;
}

void points_add(Points* points, int x, int y) {
    if (points->size >= points->capacity) {
        points->capacity *= 2;
        points->data = xrealloc(points->data, points->capacity * sizeof(Point));
    }
    points->data[points->size].x = x;
    points->data[points->size].y = y;
    points->size++;
}

void points_free(Points* points) {
    xfree(points->data);
    xfree(points);
}

void svg_header(FILE* fp, int width, int height) {
    fprintf(fp, "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>\n"
                "<!DOCTYPE svg PUBLIC \"-//W3C//DTD SVG 1.0//EN\" "
                "\"http://www.w3.org/TR/2001/REC-SVG-20010904/DTD/svg10.dtd\">\n"
                "<svg height=\"%d\" width=\"%d\" xmlns=\"http://www.w3.org/2000/svg\" "
                "xmlns:svg=\"http://www.w3.org/2000/svg\" "
                "xmlns:xlink=\"http://www.w3.org/1999/xlink\">\n",
                height, width);
}

void svg_footer(FILE* fp) {
    fprintf(fp, "</svg>\n");
}

void svg_circle(FILE* fp, int cx, int cy, int r) {
    fprintf(fp, "<circle cx=\"%d\" cy=\"%d\" r=\"%d\" stroke=\"black\" />\n", cx, cy, r);
}

void svg_point(FILE* fp, int cx, int cy) {
    svg_circle(fp, cx, cy, 1);
}

void svg_line(FILE* fp, int x1, int y1, int x2, int y2) {
    fprintf(fp, "<line x1=\"%d\" y1=\"%d\" x2=\"%d\" y2=\"%d\" stroke=\"black\" />\n", x1, y1, x2, y2);
}

void parse_input(FILE* in, Points* points, FILE* out) {
    char line[BUFSIZ];
    while (fgets(line, sizeof(line), in) != NULL) {
        char* p = strtok(line, " \t\r\n");
        while (p != NULL) {
            int x, y;
            if (sscanf(p, "%d,%d", &x, &y) == 2) {
                points_add(points, x, y);
                svg_point(out, x, y);
            }
            p = strtok(NULL, " \t\r\n");
        }
    }
}

void least_squares(Points* points, int* m, int* b) {
    int N = points->size;
    int sum_x = 0, sum_y = 0, sum_x2 = 0, sum_xy = 0;
    for (int i = 0; i < points->size; i++) {
        Point p = points->data[i];
        sum_x += p.x;
        sum_y += p.y;
        sum_x2 += p.x * p.x;
        sum_xy += p.x * p.y;
    }

    *m = (N * sum_xy - sum_x * sum_y) / (N * sum_x2 - sum_x * sum_x);
    *b = (sum_y - *m * sum_x) / N;
}

int main(int argc, char* argv[]) {
    if (argc != 2)
        die("usage: %s output_file", argv[0]);

    FILE* fp = fopen(argv[1], "w");
    if (fp == NULL)
        die("cannot open %s file", argv[1]);

    svg_header(fp, WIDTH, HEIGHT);

    Points* points = points_new();
    parse_input(stdin, points, fp);
    int m, b;
    least_squares(points, &m, &b);
    svg_line(fp, 0, b, 500, m*500+b);

    svg_footer(fp);
    fclose(fp);
    points_free(points);
}
