#include "alloc.h"

bool match_string(const char* str) {
    int count_b = 0;
    for (const char* p = str; *p; p++) {
        if (*p == 'b')
            count_b++;
        else if (*p == 'a' && count_b > 0)
            return false;
    }
    return count_b > 0;
}

int main(int argc, char* argv[]) {
    if (argc != 2)
        die("usage: %s string", argv[0]);

    bool matched = match_string(argv[1]);
    printf("%s\n", bool_to_string(matched));
}
