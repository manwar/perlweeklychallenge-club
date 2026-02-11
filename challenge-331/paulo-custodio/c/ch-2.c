#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool are_buddies(char* str1, char* str2) {
    int len = strlen(str1);
    if (len != strlen(str2))
        return false;
    for (int i = 0; i < len-1; i++) {
        for (int j = i+1; j < len; j++) {
            char t = str2[i]; str2[i] = str2[j]; str2[j] = t;
            if (strcmp(str1, str2) == 0)
                return true;
            t = str2[i]; str2[i] = str2[j]; str2[j] = t;
        }
    }
    return false;
}

int main(int argc, char* argv[]) {
    if (argc != 3) {
        fprintf(stderr, "usage: %s str1 str2\n", argv[0]);
        return EXIT_FAILURE;
    }

    bool buddies = are_buddies(argv[1], argv[2]);
    printf("%s\n", buddies ? "true" : "false");
}
