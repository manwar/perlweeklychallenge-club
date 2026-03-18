// Perl Weekly Challenge 249 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-249/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

typedef struct {
    IntArray** data;
    int size;
    int capacity;
} Permutations;

Permutations* permutations_new() {
    int capacity = 8;
    Permutations* perms = xmalloc(sizeof(Permutations));
    perms->data = xmalloc(sizeof(IntArray*) * capacity);
    perms->size = 0;
    perms->capacity = capacity;
    return perms;
}

void permutations_push_back(Permutations* perms, IntArray* perm) {
    if (perms->size >= perms->capacity) {
        perms->capacity *= 2;
        perms->data = xrealloc(perms->data, sizeof(IntArray*) * perms->capacity);
    }
    perms->data[perms->size++] = perm;
}

void permutations_free(Permutations* perms) {
    for (int i = 0; i < perms->size; i++) {
        intarray_free(perms->data[i]);
    }
    xfree(perms->data);
    xfree(perms);
}

Permutations* permutations_generate(IntArray* source) {
    Permutations* perms = permutations_new();
    if (source->size == 0) {
        IntArray* empty_perm = intarray_new();
        permutations_push_back(perms, empty_perm);
        return perms;
    }

    for (int i = 0; i < source->size; i++) {
        int value = source->data[i];
        IntArray* remaining = intarray_new();
        for (int j = 0; j < source->size; j++) {
            if (j != i) {
                intarray_push_back(remaining, source->data[j]);
            }
        }
        Permutations* sub_perms = permutations_generate(remaining);
        for (int k = 0; k < sub_perms->size; k++) {
            IntArray* perm = intarray_new();
            intarray_push_back(perm, value);
            for (int m = 0; m < sub_perms->data[k]->size; m++) {
                intarray_push_back(perm, sub_perms->data[k]->data[m]);
            }
            permutations_push_back(perms, perm);
        }
        permutations_free(sub_perms);
        intarray_free(remaining);
    }

    return perms;
}

bool check_permutation(const char* pattern, IntArray* perm) {
    if (strlen(pattern) + 1 != perm->size) {
        return false;
    }

    for (int i = 0; i < perm->size - 1; i++) {
        if (pattern[i] == 'I' && perm->data[i] > perm->data[i + 1])
            return false;
        if (pattern[i] == 'D' && perm->data[i] < perm->data[i + 1])
            return false;
    }
    return true;
}

IntArray* find_permutation(const char* pattern) {
    IntArray* result = intarray_new();

    IntArray* source = intarray_new();
    for (int i = 0; i < (int)strlen(pattern) + 1; i++) {
        intarray_push_back(source, i);
    }

    Permutations* perms = permutations_generate(source);

    for (int i = 0; i < perms->size; i++) {
        if (check_permutation(pattern, perms->data[i])) {
            for (int j = 0; j < perms->data[i]->size; j++) {
                intarray_push_back(result, perms->data[i]->data[j]);
            }
            intarray_free(source);
            permutations_free(perms);
            return result;
        }
    }

    intarray_free(source);
    permutations_free(perms);
    return result;      // empty array indicates no solution
}


int main(int argc, char* argv[]) {
    if (argc != 2)
        die("usage: %s pattern", argv[0]);

    const char* pattern = argv[1];
    IntArray* result = find_permutation(pattern);
    intarray_print(result);
    intarray_free(result);
}
