// Perl Weekly Challenge 189 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-189/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

char greater_char(const char* list, char ch) {
    char selected = ch;
    for (int i = 0; list[i] != '\0'; i++) {
        if (list[i] > ch && (selected == ch || selected > list[i]))
            selected = list[i];
    }
    return selected;
}

int main(int argc, char* argv[]) {
    if (argc != 3)
        die("usage: %s list char", argv[0]);

    char ch = greater_char(argv[1], argv[2][0]);
    printf("%c\n", ch);
}
