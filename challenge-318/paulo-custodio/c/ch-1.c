#include "alloc.h"

int count_group(const char* str) {
    int i = 0;
    while (str[i] != '\0' && str[i] == str[0])
        i++;
    return i;
}

StrArray* find_groups(const char* str) {
    StrArray* list = strarray_new();
    for (int i = 0; str[i] != '\0'; i++) {
        int n = count_group(str+i);
        if (n >= 3) {
            char* substr = xstrndup(str+i, n);
            strarray_push_back(list, substr);
            xfree(substr);
        }
        i += n - 1;
    }
    return list;
}

int main(int argc, char* argv[]) {
    if (argc != 2)
        die("usage: %s string", argv[0]);

    StrArray* list = find_groups(argv[1]);
    strarray_print(list);
    strarray_free(list);
}
