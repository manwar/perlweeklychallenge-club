#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

bool meet_zero(const char* directions) {
    int x = 0, y = 0;
    const char* p = directions;
    while (*p) {
        switch (*p) {
        case 'U': y++; break;
        case 'D': y--; break;
        case 'L': x--; break;
        case 'R': x++; break;
        default:
            fprintf(stderr, "unknonw direction: %c\n", *p);
            exit(EXIT_FAILURE);
        }

        if (x == 0 && y == 0)
            return true;
        p++;
    }
    return false;
}

int main(int argc, char* argv[]) {
    if (argc != 2) {
        fprintf(stderr, "usage: %s directions\n", argv[0]);
        return EXIT_FAILURE;
    }

    bool ok = meet_zero(argv[1]);
    printf("%s\n", ok ? "true" : "false");
}
