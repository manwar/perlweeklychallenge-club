#include "alloc.h"

int compare (const void* a, const void* b) {
    return *(char*)a - *(char*)b;
}

bool is_anagram(const char* word1_, const char* word2_) {
    if (strlen(word1_) != strlen(word2_))
        return false;

    char* word1 = xstrdup(word1_);
    qsort(word1, strlen(word1), sizeof(char), compare);
    char* word2 = xstrdup(word2_);
    qsort(word2, strlen(word2), sizeof(char), compare);

    bool ret = (strcmp(word1, word2) == 0);

    xfree(word1);
    xfree(word2);

    return ret;
}

void delete_anagrams(StrArray* words) {
    for (int i = 0; i+1 < words->size; i++) {
        if (is_anagram(words->data[i], words->data[i+1])) {
            strarray_erase(words, i);
            i--;
        }
    }
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s words...", argv[0]);

    StrArray* words = strarray_new();
    for (int i = 1; i < argc; i++)
        strarray_push_back(words, argv[i]);

    delete_anagrams(words);
    printf("%d\n", words->size);
    strarray_free(words);
}
