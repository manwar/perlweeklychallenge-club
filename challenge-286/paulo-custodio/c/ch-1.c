#include "alloc.h"

// Challenge 286

#define SEPARATORS " \t\r\n\v\f"

StrArray* read_file(const char* filename) {
    FILE* fp = fopen(filename, "r");
    if (fp == NULL)
        die("failed to open file %s", filename);

    StrArray* words = strarray_new();
    char line[BUFSIZ];
    while (fgets(line, sizeof(line), fp)) {
        char* p = strtok(line, SEPARATORS);
        while (p != NULL) {
            strarray_push_back(words, p);
            p = strtok(NULL, SEPARATORS);
        }
    }
    return words;
}

int main(int argc, char* argv[]) {
    int word = -1;
    if (argc == 2)
        word = atoi(argv[1]);
    else if (argc != 1)
        die("usage: %s [n]", argv[0]);

    StrArray* words = read_file("c/ch-1.c");
    if (word < 0)
        word = rand() % words->size;

    printf("%s\n", word < words->size ? words->data[word] : "");
    strarray_free(words);
}
