// Perl Weekly Challenge 247 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-247/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

typedef struct {
    char pair[3];
    int count;
} Pair;

void add_pair(const char* pair_, Pair* pairs, int* size) {
    // build pair from first 2 chars
    char pair[3];
    pair[0] = strlen(pair_) > 0 ? pair_[0] : ' ';
    pair[1] = strlen(pair_) > 1 ? pair_[1] : ' ';
    pair[2] = '\0';

    // find in list
    for (int i = 0; i < *size; i++) {
        if (strcmp(pair, pairs[i].pair) == 0) {
            pairs[i].count++;
            return;
        }
    }

    // add a new pair
    int idx = *size;
    strcpy(pairs[idx].pair, pair);
    pairs[idx].count = 1;
    (*size)++;
}

int compare(const void* a_, const void* b_) {
    Pair* a = (Pair*)a_;
    Pair* b = (Pair*)b_;
    if (a->count != b->count)
        return b->count - a->count;         // reverse sort by count
    else
        return strcmp(a->pair, b->pair);    // sort by pair
}

char* most_frequent_pair(const char* str) {
    if (strlen(str) <= 2)
        return xstrdup(str);

    // create empty list
    Pair* pairs = xmalloc((strlen(str)-1) * sizeof(Pair));  // upper bound
    int num_pairs = 0;

    // add pairs
    for (int i = 0; i < strlen(str)-1; i++) {
        add_pair(str+i, pairs, &num_pairs);
    }

    // sort
    qsort(pairs, num_pairs, sizeof(Pair), compare);

    // return first - most frequent in alpha order
    char* result = xstrdup(pairs[0].pair);
    xfree(pairs);
    return result;
}

int main(int argc, char* argv[]) {
    if (argc != 2)
        die("usage: %s string", argv[0]);

    char* pair = most_frequent_pair(argv[1]);
    printf("%s\n", pair);
    xfree(pair);
}
