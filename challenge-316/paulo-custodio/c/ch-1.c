#include "alloc.h"

bool is_circular(int argc, char* argv[]) {
    for (int i = 1; i < argc; i++) {
        char* last = argv[i-1];
        int last_len = strlen(last);
        if (last_len == 0)
            return false;
        if (strlen(argv[i]) == 0)
            return false;
        if (last[last_len-1] != argv[i][0])
            return false;
    }
    return true;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s words...", argv[0]);

    bool ok = is_circular(argc-1, argv+1);
    printf("%s\n", bool_to_string(ok));
}
