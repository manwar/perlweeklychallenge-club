// Perl Weekly Challenge 214 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-214/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

typedef struct {
    int index;
    int score;
    int rank;
} Score;

int compare_by_score(const void* a, const void* b) {
    return ((Score*)b)->score - ((Score*)a)->score;
}

int compare_by_index(const void* a, const void* b) {
    return ((Score*)a)->index - ((Score*)b)->index;
}

void standard_ranking(IntArray* nums) {
    // create scores list
    Score* scores = xmalloc(nums->size * sizeof(Score));
    for (int i = 0; i < nums->size; i++) {
        scores[i].index = i;
        scores[i].score = nums->data[i];
        scores[i].rank = 0;
    }

    // reverse sort by score
    qsort(scores, nums->size, sizeof(Score), compare_by_score);

    // attribute rank
    int rank = 1;
    for (int i = 0; i < nums->size; i++) {
        scores[i].rank = rank;
        int j = i+1;
        for (; j < nums->size && scores[i].score == scores[j].score; j++)
            scores[j].rank = rank;
        rank += j - i;
        i = j - 1;
    }

    // sort by index
    qsort(scores, nums->size, sizeof(Score), compare_by_index);

    // modify nums from score to rank
    for (int i = 0; i < nums->size; i++) {
        nums->data[i] = scores[i].rank;
    }

    // free scores
    xfree(scores);
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s scores...", argv[0]);

    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));

    standard_ranking(nums);

    for (int i = 0; i < nums->size; i++) {
        int rank = nums->data[i];
        if (i > 0)
            printf(" ");
        if (rank >= 1 && rank <= 3)
            printf("%c", "GSB"[rank-1]);
        else
            printf("%d", rank);
    }
    printf("\n");

    intarray_free(nums);
}
