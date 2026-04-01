// Perl Weekly Challenge 184 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-184/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

void split_numbers_letters(StrArray* in, StrArray* numbers, StrArray* letters) {
    strarray_clear(numbers);
    strarray_clear(letters);

    Str* numbers_str = str_new();
    Str* letters_str = str_new();

    for (int i = 0; i < in->size; i++) {
        const char* word = in->data[i];
        int len = strlen(word);

        str_clear(numbers_str);
        str_clear(letters_str);

        for (int j = 0; j < len; j++) {
            if (isdigit(word[j]))
                str_printf(numbers_str, "%c", word[j]);
            else if (isalpha(word[j]))
                str_printf(letters_str, "%c", word[j]);
        }

        if (numbers_str->size > 0)
            strarray_push_back(numbers, numbers_str->body);
        if (letters_str->size > 0)
            strarray_push_back(letters, letters_str->body);
    }

    str_free(numbers_str);
    str_free(letters_str);
}

void print_numbers_letters(StrArray* numbers, StrArray* letters) {
    printf("[");
    for (int i = 0; i < numbers->size; i++) {
        if (i > 0) printf(", ");
        printf("[");
        for (int j = 0; numbers->data[i][j] != '\0'; j++) {
            if (j > 0) printf(",");
            printf("%c", numbers->data[i][j]);
        }
        printf("]");
    }
    printf("]");
    printf(" and ");
    printf("[");
    for (int i = 0; i < letters->size; i++) {
        if (i > 0) printf(", ");
        printf("[");
        for (int j = 0; letters->data[i][j] != '\0'; j++) {
            if (j > 0) printf(",");
            printf("'%c'", letters->data[i][j]);
        }
        printf("]");
    }
    printf("]");
    printf("\n");
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s lists...", argv[0]);

    StrArray* in = strarray_new();
    for (int i = 1; i < argc; i++)
        strarray_push_back(in, argv[i]);

    StrArray* numbers = strarray_new();
    StrArray* letters = strarray_new();

    split_numbers_letters(in, numbers, letters);
    print_numbers_letters(numbers, letters);

    strarray_free(in);
    strarray_free(numbers);
    strarray_free(letters);
}
