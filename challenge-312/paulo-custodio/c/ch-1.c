#include "alloc.h"

int distance(char a, char b) {
    if (a == b)
        return 0;

    // make a lower than b
    if (a > b) {
        char t = a; a = b; b = t;
    }

    // direct path
    int d1 = b - a;

    // indirect path
    int d2 = ('z'-'a'+1) + a - b;

    return MIN(d1, d2);
}

int secs_to_type(const char* str) {
    int secs = 0;
    char ch = 'a';
    for (int i = 0; str[i] != '\0'; i++) {
        secs += distance(str[i], ch) + 1;   // movement + type
        ch = str[i];
    }
    return secs;
}

int main(int argc, char* argv[]) {
    if (argc != 2)
        die("usage: %s string", argv[0]);

    int secs = secs_to_type(argv[1]);
    printf("%d\n", secs);
}
