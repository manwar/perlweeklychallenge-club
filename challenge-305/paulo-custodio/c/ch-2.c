#include "alloc.h"

typedef struct {
    char* word;
    char* alien;
} AlienWord;

StrArray* parse_words() {
    char line[BUFSIZ];
    if (!fgets(line, sizeof(line), stdin))
        die("missing input data");
    return strarray_parse_list(line);
}

Str* parse_alphabet() {
    char line[BUFSIZ];
    if (!fgets(line, sizeof(line), stdin))
        die("missing input data");
    Str* alphabet = str_new();
    for (int i = 0; line[i] != '\0'; i++) {
        if (isalpha(line[i]))
            str_printf(alphabet, "%c", line[i]);
    }
    if (alphabet->size != 'z'-'a'+1)
        die("invalid alphabet size %d", alphabet->size);
    return alphabet;
}

char to_alien(char c, const char* alphabet) {
    if (!isalpha(c))
        return c;

    int len = strlen(alphabet);
    int index = tolower(c) - 'a';
    if (index < 0 || index >= len)
        return c;
    return alphabet[index];
}

char* str_to_alien(const char* word, const char* alphabet) {
    char* alien = xstrdup(word);
    for (int i = 0; word[i] != '\0'; i++) {
        alien[i] = to_alien(word[i], alphabet);
    }
    return alien;
}

int compare(const void* a, const void* b) {
    return strcmp(((AlienWord*)a)->alien, ((AlienWord*)b)->alien);
}

void alien_sort(StrArray* words, const char* alphabet) {
    // copy words, convert to alien
    AlienWord* alien_words = xcalloc(words->size, sizeof(AlienWord));
    for (int i = 0; i < words->size; i++) {
        alien_words[i].word = xstrdup(words->data[i]);
        alien_words[i].alien = str_to_alien(words->data[i], alphabet);
    }

    // sort by alien
    qsort(alien_words, words->size, sizeof(AlienWord), compare);

    // overwrite words, free alien_words
    for (int i = 0; i < words->size; i++) {
        xfree(words->data[i]);
        words->data[i] = alien_words[i].word;
        xfree(alien_words[i].alien);
    }

    xfree(alien_words);
}

int main() {
    StrArray* words = parse_words();
    Str* alphabet = parse_alphabet();
    alien_sort(words, alphabet->body);
    strarray_print(words);
    strarray_free(words);
    str_free(alphabet);
}
