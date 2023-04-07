/*
Challenge 019

Task #2
Write a script that can wrap the given paragraph at a specified column using
the greedy algorithm.
*/

#include <stdio.h>
#include <stdlib.h>
#include "utstring.h"

#define WRAP_COLUMN     72
#define BLANKS          " \t\r\n\v\f"

void read_text(UT_string* text, const char* file) {
    utstring_clear(text);

    FILE* fp = fopen(file, "r");
    if (fp == NULL) {
        perror(file);
        exit(EXIT_FAILURE);
    }

    char line[BUFSIZ];
    while (fgets(line, sizeof(line), fp)) {
        utstring_printf(text, "%s ", line);
    }

    fclose(fp);
}

void wrap_text(UT_string* result, char* text, int column) {
    utstring_clear(result);
    int pos = 0;
    const char* word = strtok(text, BLANKS);
    while (word != NULL) {
        if (pos + 1 + strlen(word) >= column) {
            utstring_printf(result, "\n%s", word);
            pos = strlen(word);
        }
        else {
            utstring_printf(result, " %s", word);
            pos += 1 + strlen(word);
        }

        word = strtok(NULL, BLANKS);
    }
}

int main(int argc, char* argv[]) {
    if (argc != 2) {
        fputs("usage: ch-2 file\n", stderr);
        return EXIT_FAILURE;
    }

    UT_string* text;
    utstring_new(text);
    UT_string* wrapped;
    utstring_new(wrapped);

    read_text(text, argv[1]);
    wrap_text(wrapped, utstring_body(text), WRAP_COLUMN);
    printf("%s\n", utstring_body(wrapped));

    utstring_free(text);
    utstring_free(wrapped);
}
