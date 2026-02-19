#include "alloc.h"

bool are_friendly(const char* s1, const char* s2) {
    int len = strlen(s1);
    if (len == 0 || strlen(s2) != len)
        return false;

    char* temp = xstrdup(s2);
    for (int i = 0; i < len - 1; i++) {
        for (int j = i+1; j < len; j++) {
            strcpy(temp, s2);
            char t = temp[i];
            temp[i] = temp[j];
            temp[j] = t;
            if (strcmp(s1, temp) == 0) {
                xfree(temp);
                return true;
            }
        }
    }
    xfree(temp);
    return false;
}

int main(int argc, char* argv[]) {
    if (argc != 3)
        die("usage: %s str1 str2", argv[0]);

    bool ok = are_friendly(argv[1], argv[2]);
    printf("%s\n", bool_to_string(ok));
}
