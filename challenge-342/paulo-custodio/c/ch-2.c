#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX(a,b) ((a) > (b) ? (a) : (b))

int compute_score(const char* binary, int index) {
    int score = 0;
    int binary_length = strlen(binary);
    for (int i = 0; i < binary_length; i++) {
        if (i < index && binary[i] == '0') {
            score++;
        }
        else if (i >= index && binary[i] == '1') {
            score++;
        }
    }
    return score;
}

int get_max_score(const char* binary) {
    int max_score = 0;
    int binary_length = strlen(binary);
    for (int i = 1; i < binary_length; i++) {
        int score = compute_score(binary, i);
        max_score = MAX(max_score, score);
    }
    return max_score;
}

int main(int argc, char* argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s binary-number\n", argv[0]);
        return EXIT_FAILURE;
    }

    int score = get_max_score(argv[1]);
    printf("%d\n", score);
}
