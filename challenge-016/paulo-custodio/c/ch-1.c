/*
Challenge 016

Task #1
Pythagoras Pie Puzzle, proposed by Jo Christian Oterhals.

At a party a pie is to be shared by 100 guest. The first guest gets 1% of the
pie, the second guest gets 2% of the remaining pie, the third gets 3% of the
remaining pie, the fourth gets 4% and so on.

Write a script that figures out which guest gets the largest piece of pie.
*/

#include <stdio.h>
#include <stdlib.h>

#define NUM_SLICES  100

struct slice {
    int guest;
    double portion;
};

int compare(const void* a, const void* b) {
    double a_portion = ((struct slice*)a)->portion;
    double b_portion = ((struct slice*)b)->portion;
    return (a_portion == b_portion) ? 0 : (a_portion < b_portion) ? 1 : -1;
}

struct slice pie_puzzle() {
    struct slice slices[NUM_SLICES];

    double pie = 1.0;
    for (int i = 1; i <= NUM_SLICES; i++) {
        slices[i - 1].guest = i;
        slices[i - 1].portion = (double)i / 100.0 * pie;
        pie -= slices[i - 1].portion;
    }

    qsort(slices, NUM_SLICES, sizeof(struct slice), compare);

    return slices[0];
}

int main() {
    struct slice result = pie_puzzle();
    printf("Guest %d gets %.4f%% of the pie.\n",
        result.guest, 100.0 * result.portion);
}
