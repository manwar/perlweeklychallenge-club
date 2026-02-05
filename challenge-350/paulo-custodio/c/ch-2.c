#include <assert.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define NUM_SIZE 64

typedef struct {
    int A;
    int count;
} Num;

Num* nums = NULL;
size_t nums_size = 0;

void add_num(int A) {
    for (size_t i = 0; i < nums_size; i++) {
        if (nums[i].A == A) {
            nums[i].count++;
            return;
        }
    }

    // add new entry
    nums_size++;
    nums = realloc(nums, nums_size * sizeof(Num));
    assert(nums != NULL);
    nums[nums_size-1].A = A;
    nums[nums_size-1].count = 1;
}

bool same_length(int a, int b) {
    char buffer[NUM_SIZE];
    sprintf(buffer, "%d", a);
    size_t length = strlen(buffer);
    sprintf(buffer, "%d", b);
    return length == strlen(buffer);
}

bool is_shuffle_pair(int a, int b) {
    int count[10] = {0};
    char buffer[NUM_SIZE];

    sprintf(buffer, "%d", a);
    for (const char* p = buffer; *p != '\0'; p++) {
        count[*p - '0']++;
    }

    sprintf(buffer, "%d", b);
    for (const char* p = buffer; *p != '\0'; p++) {
        count[*p - '0']--;
    }

    for (size_t i = 0; i < 10; i++) {
        if (count[i] != 0)
            return false;
    }

    return true;
}

int main(int argc, char* argv[]) {
    if (argc != 4) {
        fprintf(stderr, "usage: %s from to count\n", argv[0]);
        return EXIT_FAILURE;
    }

    int from = atoi(argv[1]);
    int to = atoi(argv[2]);
    int count = atoi(argv[3]);

    // enumerate pairs
    for (int A = from; A <= to; A++) {
        for (int k = 2; true; k++) {
            int B = A*k;
            if (!same_length(A, B))
                break;
            if (is_shuffle_pair(A, B))
                add_num(A);
        }
    }

    // count how many >= count
    int num = 0;
    for (size_t i = 0; i < nums_size; i++) {
        if (nums[i].count >= count)
            num++;
    }

    printf("%d\n", num);

    free(nums);
}
