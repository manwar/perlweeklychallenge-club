/*
Challenge 208

Task 1: Minimum Index Sum
Submitted by: Mohammad S Anwar

You are given two arrays of strings.

Write a script to find out all common strings in the given two arrays with
minimum index sum. If no common strings found returns an empty list.
Example 1

Input: @list1 = ("Perl", "Raku", "Love")
       @list2 = ("Raku", "Perl", "Hate")

Output: ("Perl", "Raku")

There are two common strings "Perl" and "Raku".
Index sum of "Perl": 0 + 1 = 1
Index sum of "Raku": 1 + 0 = 1

Example 2

Input: @list1 = ("A", "B", "C")
       @list2 = ("D", "E", "F")

Output: ()

No common string found, so no result.

Example 3

Input: @list1 = ("A", "B", "C")
       @list2 = ("C", "A", "B")

Output: ("A")

There are three common strings "A", "B" and "C".
Index sum of "A": 0 + 1 = 1
Index sum of "B": 1 + 2 = 3
Index sum of "C": 2 + 0 = 2
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void* check_mem(void* p) {
    if (!p) {
        fputs("Out of memory", stderr);
        exit(EXIT_FAILURE);
    }
    return p;
}

typedef struct Words {
    int count;
    char** words;
} Words;

Words* words_new() {
    return check_mem(calloc(1, sizeof(Words)));
}

void words_clear(Words* words) {
    for (int i = 0; i < words->count; i++)
        free(words->words[i]);
    words->count = 0;
}

void words_free(Words* words) {
    words_clear(words);
    free(words);
}

void words_push(Words* words, const char* word) {
    words->count++;
    words->words = check_mem(realloc(words->words,
                                     words->count * sizeof(const char*)));
    words->words[words->count-1] = check_mem(strdup(word));
}

Words* common_strings(Words* list1, Words* list2) {
    Words* common = words_new();
    int min_index = list1->count + list2->count + 1;
    for (int i = 0; i < list1->count; i++) {
        for (int j = 0; j < list2->count; j++) {
            if (strcmp(list1->words[i], list2->words[j]) == 0) {
                if (i+j < min_index) {
                    words_clear(common);
                    words_push(common, list1->words[i]);
                    min_index = i+j;
                }
                else if (i+j == min_index) {
                    words_push(common, list1->words[i]);
                    min_index = i+j;
                }
            }
        }
    }
    return common;
}

int main(int argc, char* argv[]) {
    argv++; argc--;
    if (argc % 2 != 0 || argc == 0) {
        fputs("usage: ch-2 list1 ... list2 ...\n", stderr);
        return EXIT_FAILURE;
    }

    Words* list1 = words_new();
    Words* list2 = words_new();
    for (int i = 0; i < argc/2; i++) {
        words_push(list1, argv[i]);
        words_push(list2, argv[i+argc/2]);
    }

    Words* common = common_strings(list1, list2);

    if (common->count == 0)
        printf("()\n");
    else {
        for (int i = 0; i < common->count; i++)
            printf("%s ", common->words[i]);
        printf("\n");
    }

    words_free(list1);
    words_free(list2);
    words_free(common);
}
