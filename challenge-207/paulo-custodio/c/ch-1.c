/*
Challenge 207

Task 1: Keyboard Word
Submitted by: Mohammad S Anwar

You are given an array of words.

Write a script to print all the words in the given array that can be types
using alphabet on only one row of the keyboard.

Let us assume the keys are arranged as below:

Row 1: qwertyuiop
Row 2: asdfghjkl
Row 3: zxcvbnm

Example 1

Input: @words = ("Hello","Alaska","Dad","Peace")
Output: ("Alaska","Dad")

Example 2

Input: @array = ("OMG","Bye")
Output: ()
*/

#define MAX_WORD    256

#include <assert.h>
#include <ctype.h>
#include <stdio.h>
#include <string.h>
#include <stdbool.h>

void remove_char(char* word, int ch) {
    char* p;
    while ((p = strchr(word, ch)) != NULL) {
        memmove(p, p+1, strlen(p+1)+1);     // copy also null char
    }
}

bool can_type_word(const char* keys, const char* word_) {
    char word[MAX_WORD];
    assert(strlen(word_) < MAX_WORD);
    strcpy(word, word_);
    for (char* p = word; *p != '\0'; p++)
        *p = tolower(*p);
    for (const char* p = keys; *p != '\0'; p++)
        remove_char(word, tolower(*p));
    return word[0] == '\0';
}

bool can_type(const char* word) {
    return can_type_word("qwertyuiop", word) ||
           can_type_word("asdfghjkl", word) ||
           can_type_word("zxcvbnm", word);
}

int main(int argc, char* argv[]) {
    argv++; argc--;
    for (int i = 0; i < argc; i++)
        if (can_type(argv[i]))
            printf("%s ", argv[i]);
    printf("\n");
}
