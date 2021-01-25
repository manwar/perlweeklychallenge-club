/*
Challenge 096

TASK #2 › Edit Distance
Submitted by: Mohammad S Anwar
You are given two strings $S1 and $S2.

Write a script to find out the minimum operations required to convert $S1
into $S2. The operations can be insert, remove or replace a character. Please
check out Wikipedia page for more information.

Example 1:
Input: $S1 = "kitten"; $S2 = "sitting"
Output: 3

Operation 1: replace 'k' with 's'
Operation 2: replace 'e' with 'i'
Operation 3: insert 'g' at the end
Example 2:
Input: $S1 = "sunday"; $S2 = "monday"
Output: 2

Operation 1: replace 's' with 'm'
Operation 2: replace 'u' with 'o'

NOTE: the  Wagner-Fischer Distance algorithm builds a table of distances
        from which the operations can be deduced
*/

#include <assert.h>
#include <limits.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void* check_mem(void* p) {
    if (!p) {
        fputs("Out of memory", stderr);
        exit(EXIT_FAILURE);
    }
    return p;
}

int min(int a, int b) {
    return (a < b) ? a : b;
}

int min3(int a, int b, int c) {
    return min(a, min(b, c));
}

enum { DIR_NONE, DIR_E, DIR_S, DIR_SE };

void wag_fis_dist(const char* a, const char* b) {
    int len_a = strlen(a);
    int len_b = strlen(b);

    // define a table where d[i][j] is the Levenshtein distance between
    // first i chars of a and first j chars of b
    int** d = check_mem(calloc(len_a+1, sizeof(int*)));
    for (int i = 0; i <= len_a; i++)
        d[i] = check_mem(calloc(len_b+1, sizeof(int)));

    // source prefixes can be transformed into empty string by dropping chars
    for (int i = 1; i <= len_a; i++)
        d[i][0] = i;

    // target prefixes can be reached from empty source prefix by inserting chars
    for (int j = 1; j <= len_b; j++)
        d[0][j] = j;

    // flood-fill the rest of the table
    for (int j = 1; j <= len_b; j++) {
        for (int i = 1; i <= len_a; i++) {
            int subst_cost = (a[i-1] == b[j-1]) ? 0 : 1;
            d[i][j] = min3(d[i-1][j]+1,             // deletion
                           d[i][j-1]+1,             // insertion
                           d[i-1][j-1]+subst_cost); // substitution
        }
    }

    // distance is in lower bottom cell
    printf("%d\n", d[len_a][len_b]);

    // traverse the minimum path
    int i = 0, j = 0, step = 0;
    while (i < len_a || j < len_b) {
        int min_dir = DIR_NONE, min_delta = INT_MAX;
        int dir, delta;

        // search shortest path in priority SE, E, S
        if (i < len_a && j < len_b) {
            dir = DIR_SE;
            delta = d[i+1][j+1] - d[i][j];
            if (delta < min_delta) {
                min_dir = dir;
                min_delta = delta;
            }
        }

        if (j < len_b) {
            dir = DIR_E;
            delta = d[i][j+1] - d[i][j];
            if (delta < min_delta) {
                min_dir = dir;
                min_delta = delta;
            }
        }

        if (i < len_a) {
            dir = DIR_S;
            delta = d[i+1][j] - d[i][j];
            if (delta < min_delta) {
                min_dir = dir;
                min_delta = delta;
            }
        }

        // apply shortest path and show steps
        switch (min_dir) {
        case DIR_SE:
            i++; j++;
            if (a[i-1] != b[j-1]) {
                printf("Operation %d: replace '%c' with '%c'\n",
                       ++step, a[i-1], b[j-1]);
            }
            break;
        case DIR_E:
            j++;
            if (j == len_b)
                printf("Operation %d: insert '%c' at end\n",
                       ++step, b[j-1]);
            else
                printf("Operation %d: insert '%c' at position %d\n",
                       ++step, b[j-1], j);
            break;
        case DIR_S:
            i++;
            if (i == len_a)
                printf("Operation %d: delete '%c' at end\n",
                       ++step, a[i-1]);
            else
                printf("Operation %d: delete '%c' at position %d\n",
                       ++step, a[i-1], i);
            break;
        default:
            assert(0);
        }
    }

    // free memory
    for (int i = 0; i <= len_a; i++)
        free(d[i]);
    free(d);
}

int main(int argc, char* argv[]) {
    if (argc != 3) {
        fputs("Usage: ch-2 s1 s2", stderr);
        return EXIT_FAILURE;
    }

    wag_fis_dist(argv[1], argv[2]);
}
