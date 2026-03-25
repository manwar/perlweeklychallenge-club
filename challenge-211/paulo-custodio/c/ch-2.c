// Perl Weekly Challenge 211 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-211/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

double avg(DoubleArray* a) {
    double sum = 0;
    for (int i = 0; i < a->size; i++)
        sum += a->data[i];
    return sum / (double)a->size;
}

bool same_average_1(DoubleArray* a, DoubleArray* b, DoubleArray* rest, int index) {
    if (index >= rest->size) {
        if (fabs(avg(a) - avg(b)) < Epsilon)
            return true;
        else
            return false;
    }

    double n = rest->data[index];

    // try to put rest[index] in a
    doublearray_push_back(a, n);
    if (same_average_1(a, b, rest, index+1))
        return true;
    doublearray_pop_back(a);

    // try to put rest[index] in b
    doublearray_push_back(b, n);
    if (same_average_1(a, b, rest, index+1))
        return true;
    doublearray_pop_back(b);

    // failed
    return false;
}

bool same_average(DoubleArray* nums) {
    DoubleArray* a = doublearray_new();
    DoubleArray* b = doublearray_new();
    bool ok = same_average_1(a, b, nums, 0);
    doublearray_free(a);
    doublearray_free(b);
    return ok;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...", argv[0]);

    DoubleArray* nums = doublearray_new();
    for (int i = 1; i < argc; i++)
        doublearray_push_back(nums, strtod(argv[i], NULL));

    bool ok = same_average(nums);
    printf("%d\n", (int)ok);

    doublearray_free(nums);
}
