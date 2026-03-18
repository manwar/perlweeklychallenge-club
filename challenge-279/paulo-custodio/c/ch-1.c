// Perl Weekly Challenge 279 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-279/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

typedef struct {
    char letter;
    int weight;
} Letter;

int compare(const void* a, const void* b) {
    return ((Letter*)a)->weight - ((Letter*)b)->weight;
}

int main(int argc, char* argv[]) {
    const char* string = (argc > 1) ? argv[1] : "";
    int num_letters = strlen(string);
    if (argc != 1+1+num_letters)
        die("usage: %s string weights...", argv[0]);

    // collect letters and weights
    Letter* letters = xmalloc(num_letters * sizeof(Letter));
    for (int i = 0; i < num_letters; i++) {
        letters[i].letter = string[i];
        letters[i].weight = atoi(argv[2+i]);
    }

    // sort
    qsort(letters, num_letters, sizeof(Letter), compare);

    // print
    for (int i = 0; i < num_letters; i++) {
        printf("%c", letters[i].letter);
    }
    printf("\n");

    xfree(letters);
}
