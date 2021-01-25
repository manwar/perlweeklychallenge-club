/*
Challenge 097

TASK #1 › Caesar Cipher
Submitted by: Mohammad S Anwar
You are given string $S containing alphabets A..Z only and a number $N.

Write a script to encrypt the given string $S using Caesar Cipher with left
shift of size $N.

Example
Input: $S = "THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG", $N = 3
Output: "QEB NRFZH YOLTK CLU GRJMP LSBO QEB IXWV ALD"

Plain:    ABCDEFGHIJKLMNOPQRSTUVWXYZ
Cipher:   XYZABCDEFGHIJKLMNOPQRSTUVW

Plaintext:  THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG
Ciphertext: QEB NRFZH YOLTK CLU GRJMP LSBO QEB IXWV ALD
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <memory.h>
#include <ctype.h>

void* check_mem(void* p) {
    if (!p) {
        fputs("Out of memory", stderr);
        exit(EXIT_FAILURE);
    }
    return p;
}

// replace in-place by ciphered text
void caeser(int n, char* str) {
    for (int i = 0; i < strlen(str); i++) {
        if (isalpha(str[i]))
            str[i] = ((toupper(str[i])-'A'+26-n)%26)+'A';
    }
}

int main(int argc, char* argv[]) {
    char* str = check_mem(strdup(""));
    if (argc > 2) {
        int n = atoi(argv[1]);
        for (int i = 2; i < argc; i++) {
            str = check_mem(realloc(str, strlen(str)+strlen(argv[i])+2));
            strcat(str, argv[i]);
            strcat(str, " ");
        }
        str[strlen(str)-1] = '\0';
        caeser(n, str);
        printf("%s\n", str);
    }
    free(str);
}
