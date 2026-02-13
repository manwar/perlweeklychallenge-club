#include "alloc.h"

void replace_quest(char* str) {
    int len = strlen(str);
    for (int i=0; i < len; i++) {
        if (str[i] == '?') {
            char prev = i == 0 ? '\0' : str[i-1];
            char next = str[i+1];
            for (char c = 'a'; c <= 'z'; c++) {
                if (c != prev && c != next) {
                    str[i] = c;
                    break;
                }
            }
        }
    }
}

int main(int argc, char* argv[]) {
    if (argc != 2)
        die("usage: %s string", argv[0]);

    char* str = xstrdup(argv[1]);
    replace_quest(str);
    printf("%s\n", str);
    free(str);
}
