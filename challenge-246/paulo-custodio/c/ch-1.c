// Perl Weekly Challenge 246 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-246/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

#define NUM_BALLS   49
#define NUM_DRAWS   6

IntArray* draw_lottery(int num_balls, int num_draws) {
    IntArray* balls = intarray_new();
    for (int i = 1; i <= num_balls; i++)
        intarray_push_back(balls, i);

    IntArray* draws = intarray_new();
    for (int i = 1; i <= num_draws; i++) {
        int draw = rand() % balls->size;
        intarray_push_back(draws, balls->data[draw]);
        intarray_erase(balls, draw);
    }

    intarray_free(balls);
    return draws;
}

int main(int argc, char* argv[]) {
    if (argc == 2)
        srand(atoi(argv[1]));
    else if (argc != 1)
        die("usage: %s [srand]", argv[0]);

    IntArray* draws = draw_lottery(NUM_BALLS, NUM_DRAWS);
    for (int i = 0; i < draws->size; i++)
        printf("%d\n", draws->data[i]);

    intarray_free(draws);
}
