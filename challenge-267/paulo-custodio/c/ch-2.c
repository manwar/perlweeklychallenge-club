// Perl Weekly Challenge 267 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-267/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

#define LINE_WIDTH 100

void fill_text(const char* text, IntArray* widths, int* lines, int* col) {
    *lines = 0;
    *col = 0;
    int len = strlen(text);
    if (len == 0)
        return;

    (*lines) = 1;
    for (const char* p = text; *p; p++) {
        char c = tolower(*p);

        int index = c - 'a';
        int width = 0;
        if (index >= 0 && index < widths->size)
            width = widths->data[index];

        if ((*col) + width > LINE_WIDTH) {
            (*lines)++;
            (*col) = 0;
        }

        (*col) += width;
    }
}

int main(int argc, char* argv[]) {
    if (argc < 3)
        die("usage: %s string widths...", argv[0]);

    const char* text = argv[1];
    IntArray* widths = intarray_new();
    for (int i = 2; i < argc; i++)
        intarray_push_back(widths, atoi(argv[i]));

    int lines = 0;
    int col = 0;
    fill_text(text, widths, &lines, &col);
    printf("(%d, %d)\n", lines, col);

    intarray_free(widths);
}
