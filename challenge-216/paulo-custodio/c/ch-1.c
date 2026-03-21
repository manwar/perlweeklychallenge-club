#include "../../../challenge-001/paulo-custodio/c/alloc.h"

bool has_all_letters(const char* plate, const char* word) {
    bool letters[UCHAR_MAX];

    for (const char* p = word; *p; p++)
        letters[tolower(*p)] = true;

    for (const char* p = plate; *p; p++)
        if (isalpha(*p))
            if (!letters[tolower(*p)])
                return false;

    return true;
}

int main(int argc, char* argv[]) {
    if (argc < 3)
        die("usage: %s plate words...", argv[0]);

    const char* plate = argv[1];
    const char* separator = "";
    for (int i = 2; i < argc; i++) {
        const char* word = argv[i];
        if (has_all_letters(plate, word)) {
            printf("%s%s", separator, word);
            separator = ", ";
        }
    }
    printf("\n");
}
