// Perl Weekly Challenge 233 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-233/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

typedef struct {
    int num;
    int freq;
} Num;

typedef struct {
    Num* data;
    int size;
    int capacity;
} Nums;

Nums* nums_new() {
    int capacity = 8;
    Nums* nums = xmalloc(sizeof(Nums));
    nums->data = xmalloc(capacity * sizeof(Num));
    nums->size = 0;
    nums->capacity = capacity;
}

void nums_free(Nums* nums) {
    xfree(nums->data);
    xfree(nums);
}

void nums_add(Nums* nums, int num) {
    for (int i = 0; i < nums->size; i++) {
        if (num == nums->data[i].num) {
            nums->data[i].freq++;
            return;
        }
    }

    if (nums->size >= nums->capacity) {
        nums->capacity *= 2;
        nums->data = xrealloc(nums->data, nums->capacity * sizeof(Num));
    }

    nums->data[nums->size].num = num;
    nums->data[nums->size].freq = 1;
    nums->size++;
}

int compare(const void* a_, const void* b_) {
    Num* a = (Num*)a_;
    Num* b = (Num*)b_;
    if (a->freq != b->freq)
        return a->freq - b->freq;
    else
        return b->num - a->num;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...", argv[0]);

    Nums* nums = nums_new();
    for (int i = 1; i < argc; i++)
        nums_add(nums, atoi(argv[i]));

    qsort(nums->data, nums->size, sizeof(Num), compare);

    printf("(");
    for (int i = 0; i < nums->size; i++) {
        for (int j = 0; j < nums->data[i].freq; j++) {
            if (i > 0 || j > 0)
                printf(", ");
            printf("%d", nums->data[i].num);
        }
    }
    printf(")\n");

    nums_free(nums);
}
