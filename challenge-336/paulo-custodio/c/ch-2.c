#include "alloc.h"

int* scores = NULL;
int scores_size = 0;

void push_scores(int score) {
    scores_size++;
    scores = xrealloc(scores, scores_size * sizeof(int));
    scores[scores_size-1] = score;
}

void unshift_scores(int score) {
    push_scores(0);
    memmove(scores+1, scores, (scores_size-1)*sizeof(int));
    scores[0] = score;
}

int calc_scores(char* ops[], int ops_size) {
    // be sure to have 2 entries for "+"
    push_scores(0);
    push_scores(0);

    // do operations
    for (int i = 0; i < ops_size; i++) {
        if (strcmp(ops[i], "+") == 0) {
            int next = scores[scores_size-1] + scores[scores_size-2];
            push_scores(next);
        }
        else if (strcmp(ops[i], "C") == 0) {
            scores_size--;
            if (scores_size < 2)
                unshift_scores(0);
        }
        else if (strcmp(ops[i], "D") == 0) {
            int next = 2 * scores[scores_size-1];
            push_scores(next);
        }
        else {
            int score = atoi(ops[i]);
            push_scores(score);
        }
    }

    // compute sum
    int score = 0;
    for (int i = 0; i < scores_size; i++)
        score += scores[i];

    xfree(scores);
    return score;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...", argv[0]);

    argc--; argv++;
    int score = calc_scores(argv, argc);
    printf("%d\n", score);
}
