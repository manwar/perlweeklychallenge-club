#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <assert.h>

#define ARRAY_LENGTH(arr) (sizeof(arr) / sizeof((arr)[0]))
#define ARRAY(...) __VA_ARGS__
#define STMT_START do
#define STMT_END  while (0)

void
print_uint32_array(char *prefix, uint32_t *array, size_t length) {
    printf("%s ", prefix);
    for (size_t i = 0; i < length; i++) {
        if (i > 0) {
            printf(", ");
        }
        printf("%u", array[i]);
    }
    printf("\n");
}


// Function to calculate the digit weight of a number
uint32_t digit_weight(uint32_t n) {
    uint32_t count = 0;

    while (n > 9) {
        count++;
        uint32_t tmp = 1;
        uint32_t temp_n = n;

        while (temp_n > 0) {
            tmp *= temp_n % 10;
            temp_n /= 10;
        }

        n = tmp;
    }

    return count;
}

struct sort_data {
    uint32_t *weight;
    uint32_t *data;
};
struct sort_data compare_state;

int compare(const void *a, const void *b) {
    const uint32_t l = *(uint32_t *)a;
    const uint32_t r = *(uint32_t *)b;

    if (compare_state.weight[l] == compare_state.weight[r]) {
        if (compare_state.data[l] == compare_state.data[r]) {
            return 0;
        } else if (compare_state.data[l] < compare_state.data[r]) {
            return -1;
        } else {
            return 1;
        }
    } else if (compare_state.weight[l] < compare_state.weight[r]) {
        return -1;
    } else {
        return 1;
    }
}

// Function to sort the input array based on digit weight and value
uint32_t *
persistence_sort(uint32_t *array, uint32_t length) {
    uint32_t bytes = length * sizeof(uint32_t);
    uint32_t *weight = (uint32_t *)malloc(bytes);
    uint32_t *sorted_idx = (uint32_t *)malloc(bytes);

    for (uint32_t i = 0; i < length; i++) {
        weight[i] = digit_weight(array[i]);
        sorted_idx[i] = i;
    }

    compare_state.weight = weight;
    compare_state.data = array;

    // Sort the indices based on weight and value
    qsort(sorted_idx, length, sizeof(uint32_t), compare);

    for (uint32_t i = 0; i < length; i++) {
        weight[i] = array[sorted_idx[i]];
    }
    free(sorted_idx);

    return weight;
}

#define TEST_PERSISTENCE_SORT(a,b) STMT_START {         \
    uint32_t input[] = a;                               \
    uint32_t want[]  = b;                               \
    int len = ARRAY_LENGTH(input);                      \
    int *got = persistence_sort(input, len);            \
    assert(ARRAY_LENGTH(input) == ARRAY_LENGTH(want));  \
                                                        \
    test_count++;                                       \
    print_uint32_array("# Input:", input, len);         \
    print_uint32_array("# Psort:", got, len);           \
    print_uint32_array("# Want :", want, len);          \
    printf("%sok %d\n", memcmp(got, want, sizeof(want[0]) * len) \
                        ? "not " : "", test_count);     \
    free(got);                                          \
} STMT_END


int
run_tests() {
    uint32_t test_count = 0;

    TEST_PERSISTENCE_SORT(ARRAY({15, 99, 1,  34}),
                          ARRAY({1,  15, 34, 99}));

    TEST_PERSISTENCE_SORT(ARRAY({50, 25, 33, 22}),
                          ARRAY({22, 33, 50, 25}));

    TEST_PERSISTENCE_SORT(ARRAY({12347, 2347, 347,   47,     7}),
                          ARRAY({    7,   47, 347, 2347, 12347}));

    return 0;
}


int
main(int argc, char *argv[]) {
   return run_tests();
}
