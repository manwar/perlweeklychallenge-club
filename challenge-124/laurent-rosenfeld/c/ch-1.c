#include <stdio.h>

const char * lines[] = { "   ^^^^^", "  ^     ^",
                         " ^       ^", "^         ^",
                         "     ^"};
const int indexes[] = { 0, 1, 2, 3, 3, 3, 3, 3, 3, 2, 1, 0, 4, 4, 4, 0, 4, 4 };

int main() {
    int size = sizeof (indexes) / sizeof (int);
    for (int i = 0; i < size; i++) {
        printf("%s\n", lines[indexes[i]]);
    }
}
