#include "../../../challenge-001/paulo-custodio/c/alloc.h"

StrArray* split(const char* str_, const char* separators) {
    char* str = xstrdup(str_);
    StrArray* words = strarray_new();
    char* p = strtok(str, separators);
    while (p != NULL) {
        strarray_push_back(words, p);
        p = strtok(NULL, separators);
    }
    xfree(str);
    return words;
}

void remove_spaces(char* str) {
    int w = 0;
    for (int r = 0; str[r] != '\0'; r++) {
        if (!isspace(str[r]))
            str[w++] = str[r];
    }
    str[w] = '\0';
}

void str_to_upper(char* word) {
    for (char* p = word; *p; p++)
        *p = toupper(*p);
}

bool can_type(const char* word, const char* broken_keys) {
    for (const char* p = broken_keys; *p; p++) {
        if (strchr(word, *p) != NULL) // found key
            return false;
    }
    return true;
}

int count_words(const char* input) {
    // parse input
    StrArray* sentences = split(input, ",");
    if (sentences->size != 2)
        die("invalid input: %s", input);
    StrArray* words = split(sentences->data[0], " ");
    char* broken_keys = sentences->data[1];
    remove_spaces(broken_keys);

    // convert all to upper case
    for (int i = 0; i < words->size; i++) {
        str_to_upper(words->data[i]);
    }
    str_to_upper(broken_keys);

    // count words that can be typed
    int count = 0;
    for (int i = 0; i < words->size; i++) {
        if (can_type(words->data[i], broken_keys))
            count++;
    }

    // free data
    strarray_free(sentences);
    strarray_free(words);

    return count;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s sentence,keys", argv[0]);

    Str* args = str_new();
    for (int i = 1; i < argc; i++)
        str_printf(args, "%s ", argv[i]);

    int common = count_words(args->body);
    printf("%d\n", common);
    str_free(args);
}
