/*
Challenge 099

TASK #1 › Pattern Match
Submitted by: Mohammad S Anwar
You are given a string $S and a pattern $P.

Write a script to check if given pattern validate the entire string.
Print 1 if pass otherwise 0.

The patterns can also have the following characters:

? - Match any single character.
* - Match any sequence of characters.
Example 1:
Input: $S = "abcde" $P = "a*e"
Output: 1
Example 2:
Input: $S = "abcde" $P = "a*d"
Output: 0
Example 3:
Input: $S = "abcde" $P = "?b*d"
Output: 0
Example 4:
Input: $S = "abcde" $P = "a*c?e"
Output: 1
*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

bool match(const char* s, const char* p) {
    while (true) {
        if (!*s && !*p)             // string and pattern finished
            return true;
        else if (!*s || !*p)        // either string or pattern finished
            return false;
        else if (*p == '?') {       // match any character
            s++; p++;
        }
        else if (*p == '*') {       // match any sub-sequence
            p++;
            for (int i = 0; s[i]; i++) {
                if (match(s + i, p))
                    return true;
            }
            return false;
        }
        else if (*p != *s) {        // chars different
            return false;
        }
        else {                      // search next char
            s++; p++;
        }
    }
}

int main(int argc, char* argv[]) {
    if (argc == 3)
        printf("%d\n", match(argv[1], argv[2]) ? 1 : 0);
    else {
        fputs("Usage: ch-1 string pattern", stderr);
        return EXIT_FAILURE;
    }
}
