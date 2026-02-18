#include "alloc.h"

IntArray* compute_rank(IntArray* scores) {
    // make copy of scores, sort and remove duplicates
    IntArray* uniq = intarray_new();
    for (int i = 0; i < scores->size; i++)
        intarray_push_back(uniq, scores->data[i]);
    intarray_uniq(uniq);

    // compute rank
    IntArray* rank = intarray_new();
    intarray_resize(rank, scores->size);
    for (int i = 0; i < rank->size; i++) {
        int r = intarray_find_index(uniq, scores->data[i]);
        rank->data[i] = r + 1;
    }

    intarray_free(uniq);
    return rank;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...\n", argv[0]);

    IntArray* scores = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(scores, atoi(argv[i]));

    IntArray* rank = compute_rank(scores);
    intarray_print(rank);

    intarray_free(scores);
    intarray_free(rank);
}
