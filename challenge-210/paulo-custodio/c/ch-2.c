// Perl Weekly Challenge 210 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-210/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

int find_collision(IntArray* nums) {
    for (int i = 0; i < nums->size-1; i++) {
        if (nums->data[i] > 0 && nums->data[i+1] < 0) {
            return i;
        }
    }
    return -1;  // no more colisions
}

void collide_and_explode(IntArray* nums) {
    while (true) {
        int i = find_collision(nums);
        if (i < 0)
            break;
        else if (abs(nums->data[i]) == abs(nums->data[i+1])) { // both explode
            intarray_erase(nums, i);
            intarray_erase(nums, i);
        }
        else if (abs(nums->data[i]) > abs(nums->data[i+1])) { // right explode
            intarray_erase(nums, i+1);
        }
        else {                                              // left explodes
            intarray_erase(nums, i);
        }
    }
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...", argv[0]);

    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));

    collide_and_explode(nums);
    intarray_print(nums);

    intarray_free(nums);
}
