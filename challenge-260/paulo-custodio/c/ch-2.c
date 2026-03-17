// Perl Weekly Challenge 260 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-260/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

StrArray* permutations(const char* str) {
    StrArray* result = strarray_new();
    int len = strlen(str);
    if (len == 0) {
        strarray_push_back(result, "");
        return result;
    }

    for (int i = 0; i < len; i++) {
        char c = str[i];

        // remaining chars after removing c
        Str* rest = str_new();
        for (int j = 0; j < len; j++) {
            if (j != i)
                str_printf(rest, "%c", str[j]);
        }

        // recursively permute the rest
        StrArray* sub_result = permutations(rest->body);
        for (int j = 0; j < sub_result->size; j++) {
            Str* sub_str = str_new();
            str_printf(sub_str, "%c%s", c, sub_result->data[j]);
            strarray_push_back(result, sub_str->body);
            str_free(sub_str);
        }

        strarray_free(sub_result);
        str_free(rest);
    }

    return result;
}

int dict_rank(const char* word) {
    StrArray* dict = permutations(word);
    strarray_uniq(dict);
    int rank = 1+strarray_find_index(dict, word);
    strarray_free(dict);
    return rank;
}

int main(int argc, char* argv[]) {
    if (argc != 2)
        die("usage: %s word", argv[0]);

    int rank = dict_rank(argv[1]);
    printf("%d\n", rank);
}
