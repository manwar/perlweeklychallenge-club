// Perl Weekly Challenge 219 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-219/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

IntArray* remaining_days(IntArray* days, int num_days) {
    IntArray* remaining = intarray_new();
    if (days->size == 0)
        return remaining;

    int start_day = days->data[0];
    for (int i = 0; i < days->size; i++) {
        int day = days->data[i];
        if (day >= start_day + num_days)
            intarray_push_back(remaining, day);
    }
    return remaining;
}

int calc_cost(int cost1, int cost7, int cost30, IntArray* days) {
    if (days->size == 0)
        return 0;

    // buy a 1-day pass
    IntArray* remaining1 = remaining_days(days, 1);
    int total1 = cost1 + calc_cost(cost1, cost7, cost30, remaining1);
    intarray_free(remaining1);

    // buy a 7-day pass
    IntArray* remaining7 = remaining_days(days, 7);
    int total7 = cost7 + calc_cost(cost1, cost7, cost30, remaining7);
    intarray_free(remaining7);

    // buy a 30-day pass
    IntArray* remaining30 = remaining_days(days, 30);
    int total30 = cost30 + calc_cost(cost1, cost7, cost30, remaining30);
    intarray_free(remaining30);

    return MIN(total1, MIN(total7, total30));
}

int main(int argc, char* argv[]) {
    if (argc < 5)
        die("usage: %s cost1 cost7 cost30 days...", argv[0]);

    int cost1 = atoi(argv[1]);
    int cost7 = atoi(argv[2]);
    int cost30 = atoi(argv[3]);
    IntArray* days = intarray_new();
    for (int i = 4; i < argc; i++)
        intarray_push_back(days, atoi(argv[i]));

    int cost = calc_cost(cost1, cost7, cost30, days);
    printf("%d\n", cost);

    intarray_free(days);
}
