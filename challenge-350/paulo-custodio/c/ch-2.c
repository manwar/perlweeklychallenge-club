#include "alloc.h"
#include "uthash.h"

#define NUM_SIZE 64

typedef struct {
    int A;
    int count;
    UT_hash_handle hh;
} Nums;

Nums* nums = NULL;

void add_num(int A) {
    Nums* elem = NULL;
    HASH_FIND_INT(nums, &A, elem);
    if (elem == NULL) { // not yet found
        elem = xnew(Nums);
        elem->A = A;
        elem->count = 1;
        HASH_ADD_INT(nums, A, elem);
    }
    else { // found
        elem->count++;
    }
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
    if (argc != 4)
        die("usage: %s from to count\n", argv[0]);

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
    for (Nums* p = nums; p != NULL; p = p->hh.next) {
        if (p->count >= count)
            num++;
    }

    printf("%d\n", num);

    Nums* elem, *tmp;
    HASH_ITER(hh, nums, elem, tmp) {
        HASH_DEL(nums, elem);
        xfree(elem);
    }
}
