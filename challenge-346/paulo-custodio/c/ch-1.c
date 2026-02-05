#include <stdio.h>
#include <stdlib.h>

#define MAX(a, b) ((a)>(b)?(a):(b))

int get_sequence(const char* str) {
    int nest = 0;
    int last_ok = 0;
    for (int i = 0; str[i] != '\0'; i++) {
        switch (str[i]) {
        case '(':
            nest++;
            break;
        case ')':
            if (nest == 0)
                return i;   // end of sequence
            nest--;
            break;
        default:
            fprintf(stderr, "invalid character: %c\n", str[i]);
        }
        if (nest == 0)
            last_ok = i+1;
    }
    return last_ok;
}

int get_longest_sequence(const char* str) {
    int longest = 0;
    for (int i = 0; str[i] != '\0'; i++) {
        int len = get_sequence(str+i);
        longest = MAX(longest, len);
    }
    return longest;
}

int main(int argc, char* argv[]) {
    if (argc != 2) {
        fprintf(stderr, "usage: %s str\n", argv[0]);
        return EXIT_FAILURE;
    }

    int longest = get_longest_sequence(argv[1]);
    printf("%d\n", longest);
}
