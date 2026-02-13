#include "alloc.h"
#include "uthash.h"
#include <ctype.h>

typedef struct {
    int num;
    UT_hash_handle hh;
} Nums;

void blank_non_digits(char* str) {
    for (char* p = str; *p ; p++) {
        if (!isdigit(*p))
            *p = ' ';
    }
}

Nums* parse_uniq_numbers(char* str) {
    Nums* nums = NULL;
    Nums* elem = NULL;

    char* p = strtok(str, " ");
    while (p != NULL) {
        int number = atoi(p);

        HASH_FIND_INT(nums, &number, elem);
        if (elem == NULL) { // not yet found
            elem = xcalloc(1, sizeof(Nums));
            elem->num = number;
            HASH_ADD_INT(nums, num, elem);
        }

        p = strtok(NULL, " ");
    }
    return nums;
}

int main(int argc, char* argv[]) {
    if (argc != 2)
        die("usage: %s string", argv[0]);

    // collect string, remove non digits
    char* str = xstrdup(argv[1]);
    blank_non_digits(str);

    // collect unique integers
    Nums* nums = parse_uniq_numbers(str);

    const char* separator = "";
    for (Nums* p = nums; p != NULL; p = p->hh.next) {
        printf("%s%d", separator, p->num);
        separator = ", ";
    }

    xfree(str);
    Nums* elem, *tmp;
    HASH_ITER(hh, nums, elem, tmp) {
        HASH_DEL(nums, elem);
        xfree(elem);
    }
}
