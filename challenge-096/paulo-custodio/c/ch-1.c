/*
Challenge 096

TASK #1 › Reverse Words
Submitted by: Mohammad S Anwar
You are given a string $S.

Write a script to reverse the order of words in the given string. The string
may contain leading/trailing spaces. The string may have more than one space
between words in the string. Print the result without leading/trailing spaces
and there should be only one space between words.

Example 1:
Input: $S = "The Weekly Challenge"
Output: "Challenge Weekly The"
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

int main(int argc, char* argv[]) {
    // concatenate all args
    char* text = check_mem(strdup(""));
    for (int i = 1; i < argc; i++) {
        text = check_mem(realloc(text, strlen(text)+strlen(argv[i])+2));
        strcat(text, argv[i]);
        strcat(text, " ");
    }

    // build list of words
    char** words = NULL;
    size_t num_words = 0;
    const char* sep = " ";
    char* word = strtok(text, sep);
    while (word) {
        words = check_mem(realloc(words, ++num_words * sizeof(char*)));
        words[num_words-1] = word;

        word = strtok(NULL, sep);
    }

    // print words in reverse order
    for (int i = num_words-1; i >= 0; i--)
        printf("%s ", words[i]);
    printf("\n");

    // free memory
    free(text);
    free(words);
}
