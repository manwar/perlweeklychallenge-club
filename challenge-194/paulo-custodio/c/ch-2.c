/*
Challenge 194

Task 2: Frequency Equalizer
Submitted by: Mohammad S Anwar
You are given a string made of alphabetic characters only, a-z.

Write a script to determine whether removing only one character can make the
frequency of the remaining characters the same.

Example 1:
Input: $s = 'abbc'
Output: 1 since removing one alphabet 'b' will give us 'abc' where each
alphabet frequency is the same.
Example 2:
Input: $s = 'xyzyyxz'
Output: 1 since removing 'y' will give us 'xzyyxz'.
Example 3:
Input: $s = 'xzxz'
Output: 0 since removing any one alphabet would not give us string with same
frequency alphabet.
*/

#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

#define LETTERS ('z'-'a'+1)

int freq_equalizer(const char* s) {
    int freq[LETTERS]={0};
    if (*s=='\0') return 0;
    for (const char* p=s; *p; p++) {
        if (isalpha(*p))
            freq[tolower(*p)-'a']++;
    }
    int min=0, max=0;
    for (int i=0; i<LETTERS; i++) {
        if (freq[i]) {
            if (min==0) min=max=freq[i];
            if (min>freq[i]) min=freq[i];
            if (max<freq[i]) max=freq[i];
        }
    }
    if (min+1!=max) return 0;
    int count=0;
    for (int i=0; i<LETTERS; i++) {
        if (freq[i]==max) count++;
    }
    return count==1 ? 1 : 0;
}

int main(int argc, char* argv[]) {
    argv++; argc--;
    if (argc != 1) {
        fputs("usage: ch-1 string\n", stderr);
        return EXIT_FAILURE;
    }

    printf("%d\n", freq_equalizer(argv[0]));
}
