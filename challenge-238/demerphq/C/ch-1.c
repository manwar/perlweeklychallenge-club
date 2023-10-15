#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <string.h>

#define ARRAY_LENGTH(arr) (sizeof(arr) / sizeof((arr)[0]))
#define ARRAY(...) __VA_ARGS__
#define STMT_START do
#define STMT_END  while (0)

void
print_int_array(char *prefix, int *array, size_t length) {
    printf("%s ", prefix);
    for (size_t i = 0; i < length; i++) {
        if (i > 0) {
            printf(", ");
        }
        printf("%d", array[i]);
    }
    printf("\n");
}

int *
running_sum(int *array, size_t length)  {
    int* sum = (int *)malloc(length * sizeof(int));
    if (!sum) {
        perror("Memory allocation failed");
        exit(1);
    }
    sum[0] = array[0];
    for (size_t i = 1; i < length; i++) {
        sum[i] = array[i] + sum[i - 1];
    }
    return sum;
}


#define TEST_RUNNING_SUM(a1,a2) STMT_START {            \
    int input[] = a1;                                   \
    int want[] = a2;                                    \
    int len = ARRAY_LENGTH(input);                      \
    int *got = running_sum(input, len);                 \
    assert(ARRAY_LENGTH(input) == ARRAY_LENGTH(want));  \
                                                        \
    test_count++;                                       \
    print_int_array("# Input:", input, len);            \
    print_int_array("# R Sum:", got, len);              \
    print_int_array("# Want :", want, len);             \
    printf("%sok %d\n", memcmp(got, want, sizeof(want[0]) * len) \
                        ? "not " : "", test_count);     \
    free(got);                                          \
} STMT_END


int
run_tests() {
    int test_count = 0;
    TEST_RUNNING_SUM(ARRAY({1, 2, 3, 4, 5}), ARRAY({1, 3, 6, 10, 15}));
    TEST_RUNNING_SUM(ARRAY({1, 1, 1, 1, 1}), ARRAY({1, 2, 3, 4, 5}));
    TEST_RUNNING_SUM(ARRAY({0, -1, 1, 2}),   ARRAY({0, -1, 0, 2}));
}

int
main(int argc, char *argv[]) {
   return run_tests();
}
