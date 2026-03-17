// Perl Weekly Challenge 251 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-251/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

int get_concatenation_value(IntArray* nums) {
    char buffer[32];
    int sum = 0;
    int b = 0;
    int t = nums->size-1;
    while (b <= t) {
        if (b == t) {
            sum += nums->data[b];
        }
        else {
            sprintf(buffer, "%d%d", nums->data[b], nums->data[t]);
            sum += atoi(buffer);
        }
        b++;
        t--;
    }
    return sum;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...", argv[0]);

    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));

    int sum = get_concatenation_value(nums);
    printf("%d\n", sum);

    intarray_free(nums);
}
