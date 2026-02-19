#include "alloc.h"
#include <ctype.h>

Str* get_acronym(StrArray* list) {
    Str* acronym = str_new();
    for (int i = 0; i < list->size; i++)
        str_printf(acronym, "%c", toupper(list->data[i][0]));
    return acronym;
}

StrArray* parse_words() {
    StrArray* list = strarray_new();
    char line[BUFSIZ];
    if (!fgets(line, sizeof(line), stdin))
        die("missing input data");
    const char* separators = " \t\n\r";
    char* p = strtok(line, separators);
    while (p != NULL) {
        strarray_push_back(list, p);
        p = strtok(NULL, separators);
    }
    return list;
}

Str* parse_word() {
    StrArray* list = parse_words();
    if (list->size != 1)
        die("invalid data");
    Str* word = str_new();
    str_append(word, list->data[0]);
    strarray_free(list);
    return word;
}

int main() {
    StrArray* words = parse_words();
    Str* word = parse_word();
    Str* acronym = get_acronym(words);
    bool ok = stricmp(word->body, acronym->body) == 0;
    printf("%s\n", bool_to_string(ok));
    strarray_free(words);
    str_free(word);
    str_free(acronym);
}
