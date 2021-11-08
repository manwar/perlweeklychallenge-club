/*
Challenge 005

Challenge #1
Write a program which prints out all anagrams for a given word. For more
information about Anagram, please check this wikipedia page.
create a hash of all words in dictionary where key is sorted list of letters
therefore two anagrams have the same key
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#define MAX_WORD    1024

void trim(char* str) {
    int len = strlen(str);
    while (len > 0 && isspace(str[len-1]))
        str[--len] = '\0';
}

void strtolower(char* str) {
    for (char* p = str; *p; p++)
        *p = tolower(*p);
}

int compare(const void* a, const void* b) {
    return *(const char*)a - *(const char*)b;
}

void word_key(char* key, const char* word) {
    strcpy(key, word);
    qsort(key, strlen(key), 1, compare);
}

int main(int argc, char* argv[]) {
    char key1[MAX_WORD], key2[MAX_WORD], line[MAX_WORD];

    if (argc != 2) return EXIT_FAILURE;
    word_key(key1, argv[1]);
    strtolower(key1);

    FILE* fp = fopen("words.txt", "r");
    if (!fp) return EXIT_FAILURE;

    while (fgets(line, MAX_WORD, fp)) {
        trim(line);
        strtolower(line);
        word_key(key2, line);
        if (strcmp(key1, key2) == 0)
            printf("%s\n", line);
    }

    fclose(fp);
    return EXIT_SUCCESS;
}
