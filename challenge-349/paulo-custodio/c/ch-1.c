#include <stdio.h>
#include <stdlib.h>

int power_string(const char* str) {
    int max_len = 0;
    for (int i = 0; str[i] != '\0'; i++) {
        char first = str[i];
        int j = i + 1;
        while (str[j] != '\0' && str[j] == first)
            j++;
        int len = j - i;
        if (len > max_len)
            max_len = len;
        i = j - 1;
    }
    return max_len;
}

int main(int argc, char* argv[]) {
    if (argc != 2) {
        fprintf(stderr, "usage: %s str\n", argv[0]);
        return EXIT_FAILURE;
    }

    int p = power_string(argv[1]);
    printf("%d\n", p);
}
