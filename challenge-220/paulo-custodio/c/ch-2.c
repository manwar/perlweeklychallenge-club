// Perl Weekly Challenge 220 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-220/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

typedef struct {
    IntArray** data;
    int size;
    int capacity;
} IntArrayArray;

IntArrayArray* intarrayarray_new() {
    int capacity = 8;
    IntArrayArray* aa = xmalloc(sizeof(IntArrayArray));
    aa->data = xmalloc(capacity * sizeof(IntArray*));
    aa->size = 0;
    aa->capacity = capacity;
}

void intarrayarray_add(IntArrayArray* aa, IntArray* elem) {
    if (aa->size >= aa->capacity) {
        aa->capacity *= 2;
        aa->data = xrealloc(aa->data, aa->capacity * sizeof(IntArray*));
    }
    aa->data[aa->size++] = elem;
}

void intarrayarray_free(IntArrayArray* aa) {
    for (int i = 0; i < aa->size; i++)
        intarray_free(aa->data[i]);
    xfree(aa->data);
    xfree(aa);
}

IntArrayArray* permutations(IntArray* nums) {
    if (nums->size == 0) {
        IntArray* empty = intarray_new();
        IntArrayArray* aa = intarrayarray_new();
        intarrayarray_add(aa, empty);
        return aa;
    }

    IntArrayArray* aa = intarrayarray_new();
    for (int i = 0; i < nums->size; i++) {
        int pick = nums->data[i];

        IntArray* remaining = intarray_new();
        for (int j = 0; j < nums->size; j++) {
            if (i != j)
                intarray_push_back(remaining, nums->data[j]);
        }

        IntArrayArray* sub = permutations(remaining);

        for (int j = 0; j < sub->size; j++) {
            IntArray* this = intarray_new();
            intarray_push_back(this, pick);
            for (int k = 0; k < sub->data[j]->size; k++) {
                intarray_push_back(this, sub->data[j]->data[k]);
            }

            intarrayarray_add(aa, this);
        }

        intarrayarray_free(sub);
        intarray_free(remaining);
    }

    return aa;
}


bool is_perfect_square(int n) {
    if (n < 0) return false;
    if (n < 2) return true;

    int x = n / 2;
    int last = 0;

    while (x != last) {
        last = x;
        x = (x + n / x) / 2;  // integer Newton iteration
    }

    return x * x == n;
}

bool is_squarefull(IntArray* nums) {
    for (int i = 0; i < nums->size-1; i++) {
        int sum = nums->data[i] + nums->data[i+1];
        if (!is_perfect_square(sum))
            return false;
    }
    return true;
}

IntArrayArray* all_squarefull_permutations(IntArray* nums) {
    IntArrayArray* perms = permutations(nums);
    IntArrayArray* result = intarrayarray_new();
    StrArray* all_found = strarray_new();

    for (int i = 0; i < perms->size; i++) {
        if (is_squarefull(perms->data[i])) {
            // make a copy to store in result
            IntArray* copy = intarray_new();
            Str* copy_str = str_new();
            for (int j = 0; j < perms->data[i]->size; j++) {
                int n = perms->data[i]->data[j];
                intarray_push_back(copy, n);
                str_printf(copy_str, "%d,", n);
            }

            // verify if this result has already been found
            if (strarray_find_index(all_found, copy_str->body) < 0) {   // not found
                intarrayarray_add(result, copy);
                strarray_push_back(all_found, copy_str->body);
            }

            str_free(copy_str);
        }
    }
    intarrayarray_free(perms);
    strarray_free(all_found);

    return result;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...", argv[0]);

    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));

    IntArrayArray* result = all_squarefull_permutations(nums);

    for (int i = 0; i < result->size; i++) {
        if (i > 0)
            printf(", ");
        printf("(");
        for (int j = 0; j < result->data[i]->size; j++) {
            if (j > 0)
                printf(", ");
            printf("%d", result->data[i]->data[j]);
        }
        printf(")");
    }
    printf("\n");

    intarray_free(nums);
    intarrayarray_free(result);
}
