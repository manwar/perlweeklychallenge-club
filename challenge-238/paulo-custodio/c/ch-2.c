// Perl Weekly Challenge 238 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-238/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

typedef struct {
    int num;
    int steps;
} Num;

int steps_to_single_digit(int n) {
    char buffer[32];

    int steps = 0;
    sprintf(buffer, "%d", n);
    while (strlen(buffer) > 1) {
        int prod = 1;
        for (const char* p = buffer; *p; p++) {
            prod = prod * (*p - '0');
        }
        n = prod;
        steps++;
        sprintf(buffer, "%d", n);
    }
    return steps;
}

int compare(const void* a_, const void* b_) {
    Num* a = (Num*)a_;
    Num* b = (Num*)b_;
    if (a->steps != b->steps)
        return a->steps - b->steps;
    else
        return a->num - b->num;
}

IntArray* sort_numbers(IntArray* nums) {
    Num* num_steps = xmalloc(nums->size * sizeof(Num));
    for (int i = 0; i < nums->size; i++) {
        int num = nums->data[i];
        num_steps[i].num = num;
        num_steps[i].steps = steps_to_single_digit(num);
    }

    qsort(num_steps, nums->size, sizeof(Num), compare);

    IntArray* sorted = intarray_new();
    for (int i = 0; i < nums->size; i++) {
        intarray_push_back(sorted, num_steps[i].num);
    }

    xfree(num_steps);
    return sorted;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...", argv[0]);

    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));

    IntArray* sorted = sort_numbers(nums);
    intarray_print(sorted);

    intarray_free(nums);
    intarray_free(sorted);
}
