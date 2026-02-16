#include "alloc.h"

int find_max_ones(const char* str) {
    int max_ones = 0;
    for (int i = 0; str[i] != '\0'; i++) {
        if (str[i] == '1') {
            int j = i;
            while (str[j] == '1')
                j++;
            int ones = j - i;
            max_ones = MAX(max_ones, ones);
            i = j - 1;
        }
    }
    return max_ones;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s bin...\n", argv[0]);

    Str* str = str_new();
    for (int i = 1; i < argc; i++)
        str_append(str, argv[i]);

    int max_ones = find_max_ones(str->body);
    printf("%d\n", max_ones);
    str_free(str);
}
