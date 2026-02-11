#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char prev(const char* str, int i) {
    int len = strlen(str);
    if (i == 0 || i >= len)
        return '\0';
    else
        return str[i-1];
}

char next(const char* str, int i) {
    int len = strlen(str);
    if (i < 0 || i >= len-1)
        return '\0';
    else
        return str[i+1];
}

void replace_quest(char* str) {
    int len = strlen(str);
    for (int i=0; i < len; i++) {
        if (str[i] == '?') {
            char p = prev(str, i);
            char n = next(str, i);
            for (char c = 'a'; c <= 'z'; c++) {
                if (c != p && c != n) {
                    str[i] = c;
                    break;
                }
            }
        }
    }
}

int main(int argc, char* argv[]) {
    if (argc != 2) {
        fprintf(stderr, "usage: %s string\n", argv[0]);
        return EXIT_FAILURE;
    }

    char* str = strdup(argv[1]);
    assert(str);
    replace_quest(str);
    printf("%s\n", str);
    free(str);
}
