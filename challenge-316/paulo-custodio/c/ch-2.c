#include "alloc.h"

bool is_subsequence(const char* str, const char* heap) {
    int target = 0;
    for (int src = 0; str[src] != '\0'; src++) {
        char c = str[src];
        while (heap[target] != '\0' && heap[target] != c)
            target++;
        if (heap[target] == '\0')
            return false;
        target++;
    }
    return true;
}

int main(int argc, char* argv[]) {
    if (argc != 3)
        die("usage: %s str heap", argv[0]);

    bool ok = is_subsequence(argv[1], argv[2]);
    printf("%s\n", bool_to_string(ok));
}
