#include "alloc.h"

bool is_pair(const char* s1, const char* s2) {
    int len = strlen(s1);
    if (strlen(s2) != len)
        return false;
    for (int i = 0; i < len; i++) {
        if (s1[i] != s2[len-1-i])
            return false;
    }
    return true;
}

int count_pairs(StrArray* words) {
    int count = 0;
    for (int i = 0; i < words->size-1; i++) {
        for (int j = i+1; j < words->size; j++) {
            if (is_pair(words->data[i], words->data[j]))
                count++;
        }
    }
    return count;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s words...", argv[0]);

    StrArray* words = strarray_new();
    for (int i = 1; i < argc; i++)
        strarray_push_back(words, argv[i]);

    int count = count_pairs(words);
    printf("%d\n", count);

    strarray_free(words);
}
