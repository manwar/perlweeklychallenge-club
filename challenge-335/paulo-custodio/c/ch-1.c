#include <assert.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* common_letters(char* words[], int count) {
    if (count <= 0)
        return strdup("");
    else if (count < 2)
        return strdup(words[0]);

    char* result = strdup(words[0]);
    assert(result);
    char* rp = result;

    for (int i = 0; words[0][i] != '\0'; i++) {
        char c = words[0][i];
        bool found_all = true;
        for (int j = 1; j < count; j++) {
            char* p = strchr(words[j], c);
            if (p == NULL)
                found_all = false;
            else
                *p = '#';
        }
        if (found_all) {
            *rp++ = c;
        }
    }

    *rp = '\0';
    return result;
}

int main(int argc, char* argv[]) {
    if (argc < 2) {
        fprintf(stderr, "usage: %s words...\n", argv[0]);
        return EXIT_FAILURE;
    }

    argc--; argv++;
    char* common = common_letters(argv, argc);
    assert(common);
    for (int i = 0; common[i] != '\0'; i++) {
        if (i > 0 )
            putchar(' ');
        putchar(common[i]);
    }
    putchar('\n');
    free(common);
}


