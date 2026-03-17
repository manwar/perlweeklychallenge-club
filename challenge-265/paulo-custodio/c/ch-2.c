#include "../../../challenge-001/paulo-custodio/c/alloc.h"

int count_char(const char* word, char ch) {
    int count = 0;
    for (const char* p = word; *p; p++) {
        if (tolower(*p) == tolower(ch))
            count++;
    }
    return count;
}

bool is_completing(const char* word, const char* candidate) {
    // candidate must contain at least as many alpha chars equal to word
    for (const char* p = word; *p; p++) {
        if (isalpha(*p)) {
            int count1 = count_char(word, *p);
            int count2 = count_char(candidate, *p);
            if (count2 < count1)
                return false;
        }
    }
    return true;
}

const char* shortest_completing_word(const char* str, StrArray* strs) {
    const char* shortest = "";
    for (int i = 0; i < strs->size; i++) {
        if (is_completing(str, strs->data[i])) {
            if (strlen(shortest) == 0)
                shortest = strs->data[i];
            else if (strlen(strs->data[i]) < strlen(shortest))
                shortest = strs->data[i];
        }
    }
    return shortest;
}

int main(int argc, char* argv[]) {
    if (argc < 3)
        die("usage: %s string strings...", argv[0]);

    const char* str = argv[1];
    StrArray* strs = strarray_new();
    for (int i = 2; i < argc; i++)
        strarray_push_back(strs, argv[i]);

    const char* word = shortest_completing_word(str, strs);
    printf("%s\n", word);

    strarray_free(strs);
}
