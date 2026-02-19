#include "alloc.h"

StrArray* parse_words() {
    char line[BUFSIZ];
    StrArray* words = strarray_new();
    if (!fgets(line, sizeof(line), stdin))
        return words;
    const char* separators = " \t\r\n";
    char* p = strtok(line, separators);
    while (p != NULL) {
        strarray_push_back(words, p);
        p = strtok(NULL, separators);
    }
    return words;
}

char parse_char() {
    char line[BUFSIZ];
    if (!fgets(line, sizeof(line), stdin))
        return (char)-1;

    char ch;
    if (sscanf(line, "%c", &ch) != 1)
        return (char)-1;

    return ch;
}

IntArray* index_word(StrArray* words, char ch) {
    IntArray* index = intarray_new();
    for (int i = 0; i < words->size; i++) {
        if (strchr(words->data[i], ch) != NULL)
            intarray_push_back(index, i);
    }
    return index;
}

int main() {
    StrArray* words = parse_words();
    char ch = parse_char();
    IntArray* index = index_word(words, ch);
    intarray_print(index);
    strarray_free(words);
    intarray_free(index);
}
