#include <stdio.h>
#include <stdlib.h>

int compare(const void* a, const void* b) {
    return *(int*)a - *(int*)b;
}

int main(int argc, char* argv[]) {
    if (argc != 2) {
        fputs("usage: ch-2 HAHAHA\n", stderr);
        exit(EXIT_FAILURE);
    }

    const char* wins = argv[1];
    int round1[3];
    round1[0] = wins[0] == 'H' ? 2 : 7;
    round1[1] = wins[1] == 'H' ? 3 : 6;
    round1[2] = wins[2] == 'H' ? 4 : 5;
    qsort(round1, 3, sizeof(int), compare);

    int round2[2];
    round2[0] = wins[3] == 'H' ? 1 : round1[2];
    round2[1] = wins[4] == 'H' ? round1[0] : round1[1];
    qsort(round2, 2, sizeof(int), compare);

    int winner = wins[5] == 'H' ? round2[0] : round2[1];
    int looser = wins[5] != 'H' ? round2[0] : round2[1];

    printf("Team %d defeated Team %d\n", winner, looser);
}
