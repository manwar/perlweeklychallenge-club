/*
Challenge 022

Task #2
Write a script to implement Lempel-Ziv-Welch (LZW) compression algorithm.
The script should have method to encode/decode algorithm. The wiki page
explains the compression algorithm very nicely.
*/

#include <assert.h>
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "uthash.h"
#include "utstring.h"
#include "utarray.h"

#define EOM     '#'
#define SYMBOLS "#ABCDEFGHIJKLMNOPQRSTUVWXYZ"

typedef struct dict {
    char* key;
    int id;
    UT_hash_handle hh;
} Dict;

typedef struct lzw {
    Dict* dict;
    UT_array* symbols;
} LZW;

int bits_width(int n) {
    int width = 0;
    while (n > 0) {
        n /= 2;
        width++;
    }
    return width;
}

void output_bits(UT_string* result, int n, int width) {
    UT_string* reverse_bits;
    utstring_new(reverse_bits);

    while (width > 0 || n > 0) {
        utstring_printf(reverse_bits, "%c", '0' + (n & 1));
        n /= 2;
        width--;
    }

    for (const char* p = utstring_body(reverse_bits) + utstring_len(reverse_bits) - 1;
        p >= utstring_body(reverse_bits); p--)
        utstring_printf(result, "%c", *p);

    utstring_free(reverse_bits);
}

int input_bits(const char** p, int width) {
    int result = 0;
    while (**p != '\0' && width-- > 0) {
        result *= 2;
        result += **p == '1' ? 1 : 0;
        (*p)++;
    }
    return result;
}

void* check_mem(void* p) {
    if (!p) {
        fputs("out of memory", stderr);
        exit(EXIT_FAILURE);
    }
    return p;
}

int lzw_last(LZW* lzw) {
    return utarray_len(lzw->symbols) - 1;
}

int lzw_width(LZW* lzw) {
    return bits_width(lzw_last(lzw));
}

int lzw_next_width(LZW* lzw) {
    return bits_width(lzw_last(lzw) + 1);
}

void lzw_add(LZW* lzw, const char* seq) {
    int id = lzw_last(lzw) + 1;

    Dict* elt = check_mem(calloc(1, sizeof(Dict)));
    elt->key = check_mem(strdup(seq));
    elt->id = id;
    HASH_ADD_KEYPTR(hh, lzw->dict, elt->key, strlen(elt->key), elt);

    utarray_push_back(lzw->symbols, &seq);
}

LZW* lzw_new() {
    LZW* lzw = check_mem(calloc(1, sizeof(LZW)));
    utarray_new(lzw->symbols, &ut_str_icd);

    for (const char* p = SYMBOLS; *p; p++) {
        char seq[2];
        seq[0] = *p;
        seq[1] = '\0';
        lzw_add(lzw, seq);
    }

    return lzw;
}

void lzw_free(LZW* lzw) {
    Dict* elt, * tmp;

    HASH_ITER(hh, lzw->dict, elt , tmp) {
        HASH_DEL(lzw->dict, elt);
        free(elt->key);
        free(elt);
    }

    utarray_free(lzw->symbols);
}

void lzw_longest_match(LZW* lzw, UT_string* encoded, const char** p) {
    UT_string* prefix;
    utstring_new(prefix);

    // find longest match
    int len = 0;
    while (len < strlen(*p)) {
        utstring_clear(prefix);
        utstring_printf(prefix, "%-.*s", len + 1, *p);
        Dict* elt;
        HASH_FIND_STR(lzw->dict, utstring_body(prefix), elt);
        if (elt == NULL)
            break;
        len++;
    }

    utstring_clear(prefix);
    utstring_printf(prefix, "%-.*s", len, *p);
    (*p) += len;

    Dict* elt;
    HASH_FIND_STR(lzw->dict, utstring_body(prefix), elt);
    assert(elt != NULL);
    int code = elt->id;
    int code_width = lzw_width(lzw);

    // store new prefix in dictionary
    if (**p != '\0') {
        utstring_printf(prefix, "%c", **p);
        lzw_add(lzw, utstring_body(prefix));
    }

    output_bits(encoded, code, code_width);
    utstring_free(prefix);
}

void lzw_encode(LZW* lzw, UT_string* encoded, const char* text_) {
    UT_string* text;
    utstring_new(text);
    for (const char* p = text_; *p; p++)
        if (isalpha(*p))
            utstring_printf(text, "%c", toupper(*p));
    utstring_printf(text, "%c", EOM);

    utstring_clear(encoded);
    const char* p = utstring_body(text);
    while (*p) {
        lzw_longest_match(lzw, encoded, &p);
    }

    utstring_free(text);
}

void lzw_decode(LZW* lzw, UT_string* decoded, const char* text) {
    const char* p = text;
    utstring_clear(decoded);
    while (*p) {
        int code = input_bits(&p, lzw_width(lzw));
        const char* seq = *(const char**)utarray_eltptr(lzw->symbols, code);
        utstring_printf(decoded, "%s", seq);
        if (*p) {
            int next_width = lzw_next_width(lzw);
            const char* p1 = p;
            int next_code = input_bits(&p1, next_width);
            const char* next_seq= *(const char**)utarray_eltptr(lzw->symbols, next_code);
            UT_string* next_prefix;
            utstring_new(next_prefix);
            utstring_printf(next_prefix, "%s%c", seq, *next_seq);
            lzw_add(lzw, utstring_body(next_prefix));
            utstring_free(next_prefix);
        }
    }

    // remove EOM
    utstring_body(decoded)[utstring_len(decoded) - 1] = '\0';
    utstring_len(decoded) = strlen(utstring_body(decoded));
}

void usage() {
    fputs("usage: ch-2 encode|decode text", stderr);
}

int main(int argc, char* argv[]) {
    if (argc != 3) {
        usage();
        return EXIT_FAILURE;
    }

    UT_string* result;
    utstring_new(result);
    LZW* lzw = lzw_new();

    if (strcmp(argv[1], "encode") == 0) {
        lzw_encode(lzw, result, argv[2]);
    }
    else if (strcmp(argv[1], "decode") == 0) {
        lzw_decode(lzw, result, argv[2]);
    }
    else {
        usage();
        return EXIT_FAILURE;
    }

    printf("%s\n", utstring_body(result));

    utstring_free(result);
    lzw_free(lzw);
}
