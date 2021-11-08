/*
Challenge 005

Challenge #2
Write a program to find the sequence of characters that has the most anagrams.

create a hash of all words in dictionary where key is sorted list of letters
therefore two anagrams have the same key
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include "uthash.h"

#define MAX_WORD    1024

struct anagram {
    char* key;
    int     count;
    UT_hash_handle hh;
};

struct anagram* anagrams = NULL;

void* check_mem(void* p) {
    if (!p) {
        fputs("Out of memory", stderr);
        exit(EXIT_FAILURE);
    }
    return p;
}

void trim(char* str) {
    int len = strlen(str);
    while (len > 0 && isspace(str[len - 1]))
        str[--len] = '\0';
}

void strtolower(char* str) {
    for (char* p = str; *p; p++)
        *p = tolower(*p);
}

int compare_char(const void* a, const void* b) {
    return *(const char*)a - *(const char*)b;
}

void word_key(char* key, const char* word) {
    strcpy(key, word);
    qsort(key, strlen(key), 1, compare_char);
}

int compare_anagrams(struct anagram* a, struct anagram* b) {
    return strcmp(a->key, b->key);
}

int main() {
    int max_anagrams = 0;
    char key[MAX_WORD], line[MAX_WORD];
    struct anagram* anagram, *tmp;

    FILE* fp = fopen("words.txt", "r");
    if (!fp) return EXIT_FAILURE;

    // collect anagram keys and count occurrences
    while (fgets(line, MAX_WORD, fp)) {
        trim(line);
        strtolower(line);
        word_key(key, line);

        HASH_FIND_STR(anagrams, key, anagram);
        if (!anagram) {
            anagram = check_mem(malloc(sizeof(struct anagram)));
            anagram->key = check_mem(strdup(key));
            anagram->count = 1;
            HASH_ADD_KEYPTR(hh, anagrams, anagram->key, strlen(anagram->key), anagram);
        }
        else
            anagram->count++;
        if (max_anagrams < anagram->count)
            max_anagrams = anagram->count;
    }
    fclose(fp);

    // list anagrams
    HASH_SRT(hh, anagrams, compare_anagrams);
    printf("Maximum of %d anagrams\n", max_anagrams);
    for (anagram = anagrams; anagram != NULL; anagram = anagram->hh.next) {
        if (anagram->count == max_anagrams)
            printf("%s\n", anagram->key);
    }

    // free memory
    HASH_ITER(hh, anagrams, anagram, tmp) {
        HASH_DEL(anagrams, anagram);
        free(anagram->key);
        free(anagram);
    }

    return EXIT_SUCCESS;
}
