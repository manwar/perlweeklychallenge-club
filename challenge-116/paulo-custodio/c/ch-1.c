/*
Challenge 116

TASK #1 - Number Sequence
Submitted by: Mohammad S Anwar
You are given a number $N >= 10.

Write a script to split the given number such that the difference between two
consecutive numbers is always 1 and it shouldn't have leading 0.

Print the given number if it impossible to split the number.

Example
Input: $N = 1234
Output: 1,2,3,4

Input: $N = 91011
Output: 9,10,11

Input: $N = 10203
Output: 10203 as it is impossible to split satisfying the conditions.
*/

#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

bool found_solution = false;

void* check_mem(void* p) {
    if (!p) {
        fputs("out of memory", stderr);
        exit(EXIT_FAILURE);
    }
    return p;
}

char* substr(const char* str, int start, int len) {
    int sublen = strlen(str) - start;
    assert(sublen >= 0);

    if (sublen > len) sublen = len;

    char* sub = check_mem(malloc(sublen + 1));
    strncpy(sub, str + start, sublen);
    sub[sublen] = '\0';
    return sub;
}

void print_sequences(int prev, const char* seq, const char* rest) {
    if (*rest == '\0') {        // consumed all rest
        if (!found_solution) {  // only first solution printed
            printf("%s\n", seq);
            found_solution = true;
        }
    }
    else {
        for (int i = 1; !found_solution && i <= (int)strlen(rest); i++) {
            char* prefix = substr(rest, 0, i);
            char* suffix = substr(rest, i, strlen(rest));
            char* new_seq = check_mem(malloc(strlen(seq) + 1 + strlen(prefix) + 1));
            int new_prev = atoi(prefix);

            if (suffix[0] != '0') {
                if (prev < 0) {     // first time
                    sprintf(new_seq, "%s", prefix);
                    if (!found_solution)
                        print_sequences(new_prev, new_seq, suffix);
                }
                else {
                    if (prev + 1 == new_prev) {
                        sprintf(new_seq, "%s,%s", seq, prefix);
                        if (!found_solution)
                            print_sequences(new_prev, new_seq, suffix);
                    }
                }
            }
            free(prefix);
            free(suffix);
            free(new_seq);
        }
    }
}

int main(int argc, char* argv[]) {
    if (argc != 2) return EXIT_FAILURE;
    print_sequences(-1, "", argv[1]);
}
