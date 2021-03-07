/*
Challenge 099

TASK #2 › Unique Sub-sequence
Submitted by : Mohammad S Anwar
You are given two strings $S and $T.

Write a script to find out count of different unique sub-sequences matching
$T without changing the position of characters.

Example 1:
Input : $S = "littleit', $T = 'lit'
Output : 5

    1: [lit] tleit
    2: [li] t[t] leit
    3: [li] ttlei[t]
    4: litt[l] e[it]
    5: [l] ittle[it]
Example 2:
Input : $S = "london', $T = 'lon'
Output : 3

    1: [lon] don
    2: [lo] ndo[n]
    3: [l] ond[on]
*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

int count_subsequences(const char* s, const char* t) {
    while (true) {
        if (!*t)                // t is empty, matched
            return 1;
        else if (!*s)           // s is empty, did not match
            return 0;
        else if (*s == *t) {    // same char, check two paths matching and not matching
            int matching = count_subsequences(s + 1, t + 1);
            int not_matching = count_subsequences(s + 1, t);
            return matching + not_matching;
        }
        else                    // different char, keep pattern
            s++;
    }
}

int main(int argc, char* argv[]) {
    if (argc == 3)
        printf("%d\n", count_subsequences(argv[1], argv[2]));
    else {
        fputs("Usage: ch-2 string test", stderr);
        return EXIT_FAILURE;
    }
}
