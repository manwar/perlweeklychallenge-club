#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    const char *s = argv[1];
    int c = atoi(argv[2]);
    int o = atoi(argv[3]);
    int n = strlen(s);

    char *t = strdup(s);
    for (int i = 1; i <= c; i++) {
        char tmp = t[i % n];
        t[i % n] = t[(i+o) % n];
        t[(i+o) % n] = tmp;
    }

    puts(t);
}
