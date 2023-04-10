/*
Challenge 015

Task #2
Write a script to implement Vigenère cipher. The script should be able encode
and decode. Checkout wiki page for more information.
*/

#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define LETTERS         ('Z'-'A'+1)
#define TO_LETTER(a)    ((a)+'A')
#define TO_CODE(a)      (toupper(a)-'A')

#define ENCODE      1
#define DECODE      -1

void* check_mem(void* p) {
    if (!p) {
        fputs("out of memory", stderr);
        exit(EXIT_FAILURE);
    }
    return p;
}

char* vigenere(const char* text, const char* key, int encode) {
    char* encoded = check_mem(strdup(text));
    const char* p = text;
    const char* k = key;
    char* q = encoded;
    while (*p) {
        if (isalpha(*p))
            *q++ = TO_LETTER((TO_CODE(*p++)+LETTERS+encode*TO_CODE(*k))%LETTERS);
        if (*++k == '\0')
            k = key;
    }
    *q++ = '\0';
    return encoded;
}

int main(int argc, char* argv[]) {
    if (argc != 4) {
        fputs("usage: ch-2 encode|decode key text", stderr);
        return EXIT_FAILURE;
    }

    int encode = (strcmp(argv[1], "encode") == 0) ? ENCODE : DECODE;
    const char* key = argv[2];
    const char* text = argv[3];

    char* encoded = vigenere(text, key, encode);
    printf("%s\n", encoded);

    free(encoded);
}
