#include "../../../challenge-001/paulo-custodio/c/alloc.h"

int translate_number(const char* long_form) {
    if (strcmp(long_form, "zero" ) == 0) return 0;
    if (strcmp(long_form, "one"  ) == 0) return 1;
    if (strcmp(long_form, "two"  ) == 0) return 2;
    if (strcmp(long_form, "three") == 0) return 3;
    if (strcmp(long_form, "four" ) == 0) return 4;
    if (strcmp(long_form, "five" ) == 0) return 5;
    if (strcmp(long_form, "six"  ) == 0) return 6;
    if (strcmp(long_form, "seven") == 0) return 7;
    if (strcmp(long_form, "eight") == 0) return 8;
    if (strcmp(long_form, "nine" ) == 0) return 9;
    if (strcmp(long_form, "ten"  ) == 0) return 10;
    return -1;
}

bool find_number_word(const char* sentence_, const char* word, int* number) {
    char* sentence = xstrdup(sentence_);
    char* prev = sentence;
    char* this = strtok(sentence, " ");
    while (this != NULL) {
        if (strncmp(this, word, strlen(word)) == 0) {
            *number = translate_number(prev);
            xfree(sentence);
            return (*number) >= 0 ? true : false;
        }
        prev = this;
        this = strtok(NULL, " ");
    }
    xfree(sentence);
    return false;
}

int count_vowels(const char* text) {
    int count = 0;
    for (const char* p = text; *p; p++) {
        char c = tolower(*p);
        if (c=='a' || c=='e' || c=='i' || c=='o' || c=='u')
            count++;
    }
    return count;
}

int count_consonants(const char* text) {
    int count = 0;
    for (const char* p = text; *p; p++) {
        char c = tolower(*p);
        if (c >= 'a' && c <= 'z' &&
            (c!='a' && c!='e' && c!='i' && c!='o' && c!='u'))
            count++;
    }
    return count;
}

bool sentence_is_true(const char* sentence) {
    const char* sep = strchr(sentence, '-');
    if (sep == NULL)
        return false;

    char* word = xstrndup(sentence, sep - sentence);
    int has_vowels = count_vowels(word);
    int has_consonants = count_consonants(word);
    xfree(word);

    int should_vowels = 0;
    if (!find_number_word(sep, "vowel", &should_vowels))
        return false;

    int should_consonants = 0;
    if (!find_number_word(sep, "consonant", &should_consonants))
        return false;

    return (has_vowels == should_vowels) && (has_consonants == should_consonants);
}

int main(int argc, char* argv[]) {
    if (argc != 2)
        die("usage: %s sentence", argv[0]);

    bool ok = sentence_is_true(argv[1]);
    printf("%s\n", bool_to_string(ok));
}
