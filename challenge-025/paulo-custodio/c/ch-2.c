/*
Challenge 025

Task #2
Create script to implement Chaocipher. Please checkout wiki page for more
information.
*/

#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "utstring.h"

#define LETTERS 26
#define INIT_LEFT  "HXUCZVAMDSLKPEFJRIGTWOBNYQ"
#define INIT_RIGHT "PTLNBQDEOYSFAVZKGJRIHWXUMC"

struct crypt {
    char left[LETTERS+1];
    char right[LETTERS+1];
};

struct crypt crypt;

void cat_substr(char* dest, const char* src, int start, int len) {
    dest += strlen(dest);
    src += start;
    if (len < 0)
        len = strlen(src);
    strncpy(dest, src, len);
    dest[len] = '\0';
}

void crypt_init(void) {
    strcpy(crypt.left, INIT_LEFT);
    strcpy(crypt.right, INIT_RIGHT);
}

void crypt_permute_alphapets(int pos) {
    char temp[LETTERS+1];

    // rotate left alphabet.
    temp[0] = '\0';
    cat_substr(temp, crypt.left, pos, -1);
    cat_substr(temp, crypt.left, 0, pos);
    strcpy(crypt.left, temp);

    // permute left alphabet
    temp[0] = '\0';
    cat_substr(temp, crypt.left, 0, 1);
    cat_substr(temp, crypt.left, 2, 12);
    cat_substr(temp, crypt.left, 1, 1);
    cat_substr(temp, crypt.left, 14, -1);
    strcpy(crypt.left, temp);

    // rotate right alphabet.
    temp[0] = '\0';
    cat_substr(temp, crypt.right, pos, -1);
    cat_substr(temp, crypt.right, 0, pos);
    strcpy(crypt.right, temp);

    // permute left alphabet
    temp[0] = '\0';
    cat_substr(temp, crypt.right, 1, 25);
    cat_substr(temp, crypt.right, 0, 1);
    strcpy(crypt.right, temp);

    temp[0] = '\0';
    cat_substr(temp, crypt.right, 0, 2);
    cat_substr(temp, crypt.right, 3, 11);
    cat_substr(temp, crypt.right, 2, 1);
    cat_substr(temp, crypt.right, 14, -1);
    strcpy(crypt.right, temp);
}

int find_pos(char letter, const char* alphabet) {
    const char* p = strchr(alphabet, toupper(letter));
    if (p == NULL) {
        fprintf(stderr, "Letter %c cannot be encoded\n", letter);
        exit(EXIT_FAILURE);
    }
    return p - alphabet;
}

UT_string* crypt_encode(const char* text) {
    UT_string* out;
    utstring_new(out);

    for (const char* p = text; *p != '\0'; p++) {
        if (isalpha(*p)) {
            int pos = find_pos(*p, crypt.right);
            char code = crypt.left[pos];
            utstring_printf(out, "%c", code);

            crypt_permute_alphapets(pos);
        }
    }
    return out;
}

UT_string* crypt_decode(const char* encoded) {
    UT_string* out;
    utstring_new(out);

    for (const char* p = encoded; *p != '\0'; p++) {
        if (isalpha(*p)) {
            int pos = find_pos(*p, crypt.left);
            char letter = crypt.right[pos];
            utstring_printf(out, "%c", letter);

            crypt_permute_alphapets(pos);
        }
    }
    return out;
}

void exit_usage(void) {
    fputs("usage: ch-2 encode|decode text\n", stderr);
    exit(EXIT_FAILURE);
}

int main(int argc, char* argv[]) {
    if (argc != 3)
        exit_usage();
    crypt_init();
    UT_string* out;
    if (strcmp(argv[1], "encode") == 0)
        out = crypt_encode(argv[2]);
    else if (strcmp(argv[1], "decode") == 0)
        out = crypt_decode(argv[2]);
    else
        exit_usage();
    printf("%s\n", utstring_body(out));
    utstring_free(out);
}
