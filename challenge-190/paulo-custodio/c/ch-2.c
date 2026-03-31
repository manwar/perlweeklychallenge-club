// Perl Weekly Challenge 190 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-190/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

int int_value(const char* text, int len) {
    int value = 0;
    for (int i = 0; i < len; i++) {
        if (!isdigit(text[i]))
            break;
        int digit = text[i] - '0';
        value = 10*value+digit;
    }
    return value;
}

void decodings_1(StrArray* result, Str* prefix, const char* suffix) {
    if (strlen(suffix) == 0) {
        strarray_push_back(result, prefix->body);
        return;
    }

    for (int num_len = 2; num_len >= 1; num_len--) {
        if (strlen(suffix) >= num_len) {
            int letter = int_value(suffix, num_len);
            if (letter >= 1 && letter <= 26) {
                str_printf(prefix, "%c", 'A'+letter-1);     // add a letter
                decodings_1(result, prefix, suffix+num_len);
                prefix->body[--prefix->size] = '\0';        // remove a letter
            }
        }
    }
}

StrArray* decodings(const char* code) {
    StrArray* result = strarray_new();
    Str* prefix = str_new();
    decodings_1(result, prefix, code);
    str_free(prefix);
    return result;
}

int main(int argc, char* argv[]) {
    if (argc != 2)
        die("usage: %s code", argv[0]);

    StrArray* words = decodings(argv[1]);
    strarray_sort(words);
    strarray_print(words);
    strarray_free(words);
}
