#include "alloc.h"

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s ops...\n", argv[0]);

    int x = 0;
    for (int i = 1; i < argc; i++) {
        if (strcmp(argv[i], "++x") == 0 ||
            strcmp(argv[i], "x++") == 0) {
            x++;
        }
        else if (strcmp(argv[i], "--x") == 0 ||
                 strcmp(argv[i], "x--") == 0) {
            x--;
        }
        else {
            die("unknonw operation: %s", argv[i]);
        }
    }

    printf("%d\n", x);
}
