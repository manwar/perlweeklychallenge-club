/*
Challenge 209

Task 1: Special Bit Characters
Submitted by: Mohammad S Anwar

You are given an array of binary bits that ends with 0.

Valid sequences in the bit string are:

[0] -decodes-to-> "a"
[1, 0] -> "b"
[1, 1] -> "c"

Write a script to print 1 if the last character is an “a” otherwise print 0.
Example 1

Input: @bits = (1, 0, 0)
Output: 1

The given array bits can be decoded as 2-bits character (10) followed by
1-bit character (0).

Example 2

Input: @bits = (1, 1, 1, 0)
Output: 0

Possible decode can be 2-bits character (11) followed by 2-bits character
(10) i.e. the last character is not 1-bit character.
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "utstring.h"

void decode(UT_string* out, const char* in) {
    const char* p = in;
    while (*p) {
        switch (*p) {
        case '0': utstring_printf(out, "%c", 'a'); p++; break;
        case '1':
            p++;
            switch (*p) {
            case '0': utstring_printf(out, "%c", 'b'); p++; break;
            case '1': utstring_printf(out, "%c", 'c'); p++; break;
            default: fputs("invalid input", stderr); exit(EXIT_FAILURE);
            }
            break;
        default: fputs("invalid input", stderr); exit(EXIT_FAILURE);
        }
    }
}

int main(int argc, char* argv[]) {
    argv++; argc--;
    if (argc != 1) {
        fputs("usage: ch-2 str\n", stderr);
        return EXIT_FAILURE;
    }

    UT_string* out;
	utstring_new(out);
	
    decode(out, argv[0]);
    printf("%d\n", utstring_body(out)[utstring_len(out)-1] == 'a' ? 1 : 0);
	
	utstring_free(out);
}
