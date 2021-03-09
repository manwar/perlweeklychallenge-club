/*
Challenge 102

TASK #2 › Hash-counting String
Submitted by: Stuart Little

You are given a positive integer $N.

Write a script to produce Hash-counting string of that length.

The definition of a hash-counting string is as follows:
- the string consists only of digits 0-9 and hashes, ‘#’
- there are no two consecutive hashes: ‘##’ does not appear in your string
- the last character is a hash
- the number immediately preceding each hash (if it exists) is the position
of that hash in the string, with the position being counted up from 1

It can be shown that for every positive integer N there is exactly one such
length-N string.
Examples:

(a) "#" is the counting string of length 1
(b) "2#" is the counting string of length 2
(c) "#3#" is the string of length 3
(d) "#3#5#7#10#" is the string of length 10
(e) "2#4#6#8#11#14#" is the string of length 14
*/

#include <stdio.h>
#include <stdlib.h>

void* check_mem(void* p) {
    if (!p) {
        fputs("Out of memory", stderr);
        exit(EXIT_FAILURE);
    }
    return p;
}

char* hash_count(int n) {
    char* str = check_mem(malloc(n + 1));
    str[n] = '\0';
    int i = n - 1;
    while (i >= 0) {
        int pos = i + 1;
        str[i--] = '#';
        while (i >= 0 && pos != 0) {
            str[i--] = '0' + (pos % 10);
            pos /= 10;
        }
    }
    return str;
}


int main(int argc, char* argv[]) {
    if (argc != 2) {
        fputs("Usage: ch-1 N\n", stderr);
        return EXIT_FAILURE;
    }
    else {
        char* str = hash_count(atoi(argv[1]));
        printf("%s\n", str);
        free(str);
    }
}
