// Perl Weekly Challenge 165 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-165/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

#define WIDTH  500
#define HEIGHT 500

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

void parse_input(FILE* in, FILE* out) {
    char line[BUFSIZ];
    while (fgets(line, sizeof(line), in) != NULL) {
        int x1, y1, x2, y2;
        if (sscanf(line, "%d,%d,%d,%d", &x1, &y1, &x2, &y2) == 4)
            svg_line(out, x1, y1, x2, y2);
        else if (sscanf(line, "%d,%d", &x1, &y1) == 2)
            svg_point(out, x1, y1);
        else
            die("cannot parse: %s", line);
    }
}

int main(int argc, char* argv[]) {
    if (argc != 2)
        die("usage: %s output_file", argv[0]);

    FILE* fp = fopen(argv[1], "w");
    if (fp == NULL)
        die("cannot open %s file", argv[1]);

    svg_header(fp, WIDTH, HEIGHT);
    parse_input(stdin, fp);
    svg_footer(fp);
    fclose(fp);
}
