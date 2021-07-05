/*
Challenge 115

TASK #1 - String Chain
Submitted by: Mohammad S Anwar
You are given an array of strings.

Write a script to find out if the given strings can be chained to form a
circle. Print 1 if found otherwise 0.

A string $S can be put before another string $T in circle if the last
character of $S is same as first character of $T.

Examples:
Input: @S = ("abc", "dea", "cd")
Output: 1 as we can form circle e.g. "abc", "cd", "dea".

Input: @S = ("ade", "cbd", "fgh")
Output: 0 as we can't form circle.
*/

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include "utlist.h"

typedef struct Word {
    char* word;
    struct Word* next, * prev;
} Word;

void* check_mem(void* p) {
    if (!p) {
        fputs("out of memory", stderr);
        exit(EXIT_FAILURE);
    }
    return p;
}

void words_push_back(Word** phead, const char* word) {
    Word* node = check_mem(malloc(sizeof(Word)));
    node->word = check_mem(strdup(word));
    DL_APPEND(*phead, node);
}

void words_delete(Word** phead, const char* word) {
    Word* node, * temp;
    DL_FOREACH_SAFE(*phead, node, temp) {
        if (strcmp(node->word, word) == 0) {
            DL_DELETE(*phead, node);
            free(node->word);
            free(node);
        }
    }
}

Word* words_clone(Word** phead) {
    Word* node, * temp, * new_words = NULL;
    DL_FOREACH_SAFE(*phead, node, temp) {
        words_push_back(&new_words, node->word);
    }
    return new_words;
}

void words_free(Word** phead) {
    while (*phead) {
        Word* node = *phead;
        DL_DELETE(*phead, node);
        free(node->word);
        free(node);
    }
}

bool is_chain(char* word1, char* word2) {
    if (word1[strlen(word1) - 1] == word2[0])
        return true;
    else
        return false;
}

bool found_solution = false;

bool is_circle(Word* pending, Word* path) {
    if (found_solution) return true;
    if (pending == NULL) {
        if (!found_solution) found_solution = is_chain(path->prev->word, path->word);
    }
    else {
        Word* node, * temp;
        DL_FOREACH_SAFE(pending, node, temp) {
            if (!found_solution) {
                if (path == NULL || is_chain(path->prev->word, node->word)) {
                    Word* new_pending = words_clone(&pending);
                    words_delete(&new_pending, node->word);
                    Word* new_path = words_clone(&path);
                    words_push_back(&new_path, node->word);

                    if (!found_solution) found_solution = is_circle(new_pending, new_path);

                    words_free(&new_pending);
                    words_free(&new_path);
                }
            }
        }
    }
    return found_solution;
}

int main(int argc, char* argv[]) {
    Word* words = NULL;
    for (int i = 1; i < argc; i++)
        words_push_back(&words, argv[i]);
    bool found = is_circle(words, NULL);
    printf("%d\n", found ? 1 : 0);
    words_free(&words);
}
