#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define MAX_ITER 500
#define MAX_VAL 10000000
#define NB_TESTS 6

void reverse_str(char* str) {
    int len, tmp;
    len = strlen(str);
    for (int i = 0; i < len/2; i++) {
        tmp = str[i];
        str[i] = str[len - i - 1];
        str[len - i - 1] = tmp;
    }
}

const char* lychrel (int n) {
    char out[20];
    for (int k = 1; k <= MAX_ITER; k++) {
        if (n > MAX_VAL) {
            return "is a Lychrel candidate. Reached the 1e7 limit";
        }
        char to_str[20];
        char rev[20];
        sprintf(to_str, "%d", n);
        strcpy(rev, to_str);
        reverse_str(rev);
        if (strcmp(to_str, rev) == 0) {
            return "0";
        }
        n += atoi(rev);
    }
    return "is a Lychrel candidate. Reached 500 iterations";
}

int main() {
    int tests[NB_TESTS] = { 10, 20, 30, 50, 100, 196};
    for (int i = 0; i < NB_TESTS; i++) {
        printf("%d -> %s\n", tests[i], lychrel(tests[i]));
    }
}
