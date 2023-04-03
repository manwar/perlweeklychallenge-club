/*
Challenge 014

Challenge #1
Write a script to generate Van Eck’s sequence starts with 0. For more
information, please check out wikipedia page. This challenge was proposed by
team member Andrezgz.
*/

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

void* check_mem(void* p) {
    if (!p) {
        fputs("Out of memory", stderr);
        exit(EXIT_FAILURE);
    }
    return p;
}

int* van_eck_seq(int N) {
    int* nums = check_mem(malloc(N * sizeof(int)));
    nums[0] = nums[1] = 0;
    for (int i = 2; i < N; i++) {
        bool found = false;
        for (int m = i-2; !found && m >= 0; m--) {
            if (nums[m] == nums[i-1]) {
                nums[i] = i-1-m;
                found = true;
            }
        }
        if (!found)
            nums[i] = 0;
    }
    return nums;
}

int main(int argc, char* argv[]) {
    if (argc != 2) {
        fputs("usage: ch-1 N\n", stderr);
        return EXIT_FAILURE;
    }

    int N = atoi(argv[1]);
    int* nums = van_eck_seq(N);

    const char* sep = "";
    for (int i = 0; i < N; i++) {
        printf("%s%d", sep, nums[i]);
        sep = ", ";
    }
    printf("\n");

    free(nums);
}
