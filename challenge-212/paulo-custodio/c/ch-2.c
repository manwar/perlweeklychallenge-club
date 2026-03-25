// Perl Weekly Challenge 212 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-212/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

typedef struct {
    IntArray** groups;
    int size;
} Groups;

Groups* groups_new(int size) {
    Groups* groups = xmalloc(sizeof(Groups));
    groups->groups = xmalloc(size * sizeof(IntArray*));
    groups->size = size;
    for (int i = 0; i < groups->size; i++)
        groups->groups[i] = intarray_new();
    return groups;
}

void groups_free(Groups* groups) {
    for (int i = 0; i < groups->size; i++)
        intarray_free(groups->groups[i]);
    xfree(groups->groups);
    xfree(groups);
}

Groups* distribute(IntArray* nums, int group_size) {
    if (nums->size == 0)
        return NULL;
    if (nums->size % group_size != 0)
        return NULL;
    int N = nums->size / group_size;

    // sort the input
    intarray_sort(nums);

    // create group structure
    Groups* groups = groups_new(N);

    // create each group
    for (int i = 0; i < N; i++) {
        IntArray* group = groups->groups[i];

        // put smallest in group
        int n = nums->data[0];
        intarray_push_back(group, n);
        intarray_erase(nums, 0);

        // find sequences to fill the group
        for (int j = 1; j < group_size; j++) {
            int found = intarray_find_index(nums, n+1);
            if (found < 0) {    // no solution
                groups_free(groups);
                return NULL;
            }
            int next = nums->data[found];
            intarray_push_back(group, next);
            intarray_erase(nums, found);
            n = next;
        }
    }

    return groups;
}

int main(int argc, char* argv[]) {
    if (argc < 3)
        die("usage: %s nums... size", argv[0]);

    int group_size = atoi(argv[--argc]);
    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));

    Groups* groups = distribute(nums, group_size);
    if (groups == NULL) {
        printf("-1\n");
    }
    else {
        for (int i = 0; i < groups->size; i++) {
            if (i > 0) printf(", ");
            printf("(");
            for (int j = 0; j < groups->groups[i]->size; j++) {
                if (j > 0) printf(",");
                printf("%d", groups->groups[i]->data[j]);
            }
            printf(")");
        }
        printf("\n");

        groups_free(groups);
    }

    intarray_free(nums);
}
