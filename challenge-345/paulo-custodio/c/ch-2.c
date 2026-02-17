#include "alloc.h"

void last_visitor(IntArray* nums, IntArray* ans) {
    IntArray* seen = intarray_new();

    int x = 0;  // how many -1s in a row BEFORE this one
    for (int i = 0; i < nums->size; i++) {
        int n = nums->data[i];
        if (n >= 0) {
            intarray_push_front(seen, n);
            x = 0;  // reset streak
        }
        else {
            // use current x
            int n = (x < seen->size) ? seen->data[x] : -1;
            intarray_push_back(ans, n);
            x++;    // increment streak for next -1
        }
    }

    intarray_free(seen);
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...", argv[0]);

    argv++; argc--;
    IntArray* nums = intarray_new();
    for (int i = 0; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));

    IntArray* ans = intarray_new();
    last_visitor(nums, ans);
    intarray_print(ans);

    intarray_free(nums);
    intarray_free(ans);
}
