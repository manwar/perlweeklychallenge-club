#include "alloc.h"
#include <ctype.h>

char *make_lower_upper_keys(const char* input) {
    char* keys = xmalloc(strlen(input)*2+1);
    char* kp = keys;
    for (int i = 0; input[i] != '\0'; i++) {
        *kp++ = tolower(input[i]);
        *kp++ = toupper(input[i]);
    }
    *kp = '\0';
    return keys;
}

bool can_type_word(const char* word, const char* keys) {
    for (int i = 0; word[i] != '\0'; i++) {
        if (strchr(keys, word[i]) != NULL)
            return false;
    }
    return true;
}

int can_type(char* sentence, const char* keys) {
    int count = 0;
    char* word = strtok(sentence, " ");
    while (word != NULL) {
        if (can_type_word(word, keys))
            count++;
        word = strtok(NULL, " ");
    }
    return count;
}

int main(int argc, char* argv[]) {
    if (argc != 3)
        die("usage: %s sentence keys\n", argv[0]);

    // make modifieable copy of sentence
    char* sentence = xstrdup(argv[1]);

    // make upper and lower case version of each key
    char* keys = make_lower_upper_keys(argv[2]);

    // count words than can be typed
    int count = can_type(sentence, keys);
    printf("%d\n", count);

    xfree(sentence);
    xfree(keys);
}
