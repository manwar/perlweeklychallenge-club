#include <assert.h>
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void capitalize_word(char* p) {
    if (strlen(p) <= 2) {
        for ( ; *p; p++)
            *p = tolower(*p);
    }
    else {
        *p = toupper(*p);
        for (p++; *p; p++)
            *p = tolower(*p);
    }
}

char* capitalize(char* words[], int count) {
    char* output = malloc(1);
    assert(output);
    output[0] = '\0';

    for (int i = 0; i < count; i++) {
        capitalize_word(words[i]);
        output = realloc(output, strlen(output) + 1 + strlen(words[i]) + 1);
        assert(output);
        if (i > 0)
            strcat(output, " ");
        strcat(output, words[i]);
    }
    return output;
}

int main(int argc, char* argv[]) {
    if (argc < 2) {
        fprintf(stderr, "usage: %s sentence\n", argv[0]);
        return EXIT_FAILURE;
    }

    argc--; argv++;
    char* result = capitalize(argv, argc);
    printf("%s\n", result);
    free(result);
}
