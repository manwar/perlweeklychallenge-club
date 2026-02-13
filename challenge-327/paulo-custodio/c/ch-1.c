#include "alloc.h"
#include "uthash.h"

typedef struct {
    int num;
    UT_hash_handle hh;
} Nums;

Nums* collect_args(Nums* nums, int argc, char* argv[]) {
    Nums* elem = NULL;

    for (int i = 0; i < argc; i++) {
        int num = atoi(argv[i]);

        HASH_FIND_INT(nums, &num, elem);
        if (elem == NULL) { // not yet found
            elem = xcalloc(1, sizeof(Nums));
            elem->num = num;
            HASH_ADD_INT(nums, num, elem);
        }
    }
    return nums;
}

void print_missing_nums(Nums* nums, int count) {
    Nums* elem = NULL;

    const char* separator = "";
    for (int num = 1; num <= count; num++) {
        HASH_FIND_INT(nums, &num, elem);
        if (elem == NULL) { // not found
            printf("%s%d", separator, num);
            separator = ", ";
        }
    }
    printf("\n");
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...\n", argv[0]);

    argc--; argv++;
    Nums* nums = collect_args(NULL, argc, argv);
    print_missing_nums(nums, argc);

    Nums* elem, *tmp;
    HASH_ITER(hh, nums, elem, tmp) {
        HASH_DEL(nums, elem);
        xfree(elem);
    }
}
