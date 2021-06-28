/*
Challenge 004
Challenge #2
You are given a file containing a list of words (case insensitive 1 word per
line) and a list of letters. Print each word from the file that can be made
using only letters from the list. You can use each letter only once (though
there can be duplicates and you can use each of them once), you don’t have to
use all the letters. (Disclaimer: The challenge was proposed by Scimon Proctor)
*/

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <ctype.h>

#define MAX_WORD    1024

void strtolower(char* str) {
    for (char* p = str; *p; p++)
        *p = tolower(*p);
}

bool strisalpha(const char* str) {
    for (const char* p = str; *p; p++)
        if (!isalpha(*p))
            return false;
    return true;
}

void trim(char* str) {
    int len = strlen(str);
    while (len > 0 && isspace(str[len-1]))
        str[--len] = '\0';
}

bool matches(const char* word, const char* letters) {
    char pending[MAX_WORD];
    strcpy(pending, word);
    for (const char* p = letters; *p; p++) {
        char* found = strchr(pending, *p);
        if (found) *found = ' ';
    }
    for (char* p = pending; *p; p++)
        if (*p != ' ') return false;
    return true;
}

int main(int argc, char* argv[]) {
    if (argc != 2) return EXIT_FAILURE;

    char letters[MAX_WORD];
    strcpy(letters, argv[1]);
    strtolower(letters);

    FILE* fp = fopen("words.txt", "r");
    if (!fp) return EXIT_FAILURE;

    char word[MAX_WORD];
    while (fgets(word,sizeof(word),fp)) {
        trim(word);
        if (strlen(word) >= 2 &&
            strisalpha(word) &&
            matches(word, letters)
            )
            printf("%s\n", word);
    }

    fclose(fp);
    return EXIT_SUCCESS;
}
