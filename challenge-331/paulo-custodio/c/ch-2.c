#include "alloc.h"

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
    if (argc != 3)
        die("usage: %s str1 str2", argv[0]);

    char* str1 = xstrdup(argv[1]);
    char* str2 = xstrdup(argv[2]);

    bool buddies = are_buddies(str1, str2);
    printf("%s\n", buddies ? "true" : "false");

    xfree(str1);
    xfree(str2);
}
