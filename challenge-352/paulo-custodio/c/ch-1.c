#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool find_word(const char* word, int argc, char* argv[]) {
    for (int i = 0; i < argc; i++) {
        if (strcmp(word, argv[i]) == 0)
            return true;
    }
    return false;
}

int main(int argc, char* argv[]) {
    if (argc < 2) {
        fprintf(stderr, "usage: %s strs...\n", argv[0]);
        return EXIT_FAILURE;
    }

    argv++; argc--;
    const char *separator = "";
    for (int i = 0; i < argc; i++) {
        if (find_word(argv[i], i, argv))
            continue;
        bool found = false;
        for (int j = 0; !found && j < argc; j++) {
            if (i != j && strstr(argv[j], argv[i]) != NULL) {
                printf("%s%s", separator, argv[i]);
                separator = ", ";
                found = true;
            }
        }
    }
    printf("\n");
}
