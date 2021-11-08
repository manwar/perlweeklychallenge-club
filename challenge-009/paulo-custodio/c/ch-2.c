/*
Challenge 009

Challenge #2
Write a script to perform different types of ranking as described below:

1. Standard Ranking (1224): Items that compare equal receive the same ranking
   number, and then a gap is left in the ranking numbers.
2. Modified Ranking (1334): It is done by leaving the gaps in the ranking
   numbers before the sets of equal-ranking items.
3. Dense Ranking    (1223): Items that compare equally receive the same
   ranking number, and the next item(s) receive the immediately following
   ranking number.
*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

typedef struct score_t {
    int seq;
    int score;
    int rank;
} score_t;

void* check_mem(void* p) {
    if (!p) {
        fputs("Out of memory", stderr);
        exit(EXIT_FAILURE);
    }
    return p;
}

int rev_by_score(const void* a, const void* b) {
    return -(((score_t*)a)->score - ((score_t*)b)->score);  // reverse-sort
}

int by_seq(const void* a, const void* b) {
    return ((score_t*)a)->seq - ((score_t*)b)->seq;
}

void standard_ranking(int num_scores, score_t* scores) {
    qsort(scores, num_scores, sizeof(score_t), rev_by_score);
    int rank = 1;
    for (int i = 0; i < num_scores; i++) {
        int count = 0;
        for (int j = i; j < num_scores && scores[i].score == scores[j].score; j++) {
            count++;
            scores[j].rank = rank;
        }
        rank += count;
        i += count - 1;
    }
    qsort(scores, num_scores, sizeof(score_t), by_seq);
}

void modified_ranking(int num_scores, score_t* scores) {
    qsort(scores, num_scores, sizeof(score_t), rev_by_score);
    int rank = 1;
    for (int i = 0; i < num_scores; i++) {
        int count = 0;
        for (int j = i; j < num_scores && scores[i].score == scores[j].score; j++)
            count++;
        rank += count-1;
        for (int j = i; j < num_scores && scores[i].score == scores[j].score; j++)
            scores[j].rank = rank;
        rank++;
        i += count - 1;
    }
    qsort(scores, num_scores, sizeof(score_t), by_seq);
}

void dense_ranking(int num_scores, score_t* scores) {
    qsort(scores, num_scores, sizeof(score_t), rev_by_score);
    int rank = 1;
    for (int i = 0; i < num_scores; i++) {
        int count = 0;
        for (int j = i; j < num_scores && scores[i].score == scores[j].score; j++) {
            count++;
            scores[j].rank = rank;
        }
        rank++;
        i += count - 1;
    }
    qsort(scores, num_scores, sizeof(score_t), by_seq);
}


int main(int argc, char* argv[]) {
    if (argc < 2) return EXIT_FAILURE;
    int num_scores = argc - 1;
    score_t* scores = check_mem(calloc(num_scores, sizeof(score_t)));
    for (int i = 0; i < num_scores; i++) {
        scores[i].seq = i;
        scores[i].score = atoi(argv[i + 1]);
    }

    printf("Data:             ");
    for (int i = 0; i < num_scores; i++) {
        printf("%d", scores[i].score);
        if (i + 1 < num_scores)
            printf(", ");
    }
    printf("\n");

    standard_ranking(num_scores, scores);
    printf("Standard ranking: ");
    for (int i = 0; i < num_scores; i++) {
        printf("%d", scores[i].rank);
        if (i + 1 < num_scores)
            printf(", ");
    }
    printf("\n");

    modified_ranking(num_scores, scores);
    printf("Modified ranking: ");
    for (int i = 0; i < num_scores; i++) {
        printf("%d", scores[i].rank);
        if (i + 1 < num_scores)
            printf(", ");
    }
    printf("\n");

    dense_ranking(num_scores, scores);
    printf("Dense ranking:    ");
    for (int i = 0; i < num_scores; i++) {
        printf("%d", scores[i].rank);
        if (i + 1 < num_scores)
            printf(", ");
    }
    printf("\n");

    free(scores);
}
