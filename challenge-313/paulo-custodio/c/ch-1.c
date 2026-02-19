#include "alloc.h"

bool is_typed(const char* name, const char* typed) {
    int kbd = 0;
    for (int i = 0; name[i] != '\0'; i++) {
        if (typed[kbd] == '\0' || typed[kbd] != name[i])
            return false;
        // skip repetitions
        if (name[i+1] != name[i]) {
            while (typed[kbd] != '\0' && typed[kbd] == name[i])
                kbd++;
        }
    }
    if (typed[kbd] == '\0')
        return true;
    else
        return false;
}

int main(int argc, char* argv[]) {
    if (argc != 3)
        die("usage: %s name typed", argv[0]);

    bool ok = is_typed(argv[1], argv[2]);
    printf("%s\n", bool_to_string(ok));
}
