#include "../../../challenge-001/paulo-custodio/c/alloc.h"

bool isvowel(char a) {
    a = tolower(a);
    return a=='a' || a=='e' || a=='i' || a=='o' || a=='u';
}

Str* goat_latin(StrArray* words) {
    Str* output = str_new();
    for (int i = 0; i < words->size; i++) {
        if (i > 0)
            str_append(output, " ");

        const char* word = words->data[i];
        if (isvowel(word[0]))
            str_printf(output, "%sma", word);
        else
            str_printf(output, "%s%cma", word+1, word[0]);
        for (int j = 0; j < i+1; j++)
            str_append(output, "a");
    }
    return output;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s words...", argv[0]);

    StrArray* words = strarray_new();
    for (int i = 1; i < argc; i++)
        strarray_push_back(words, argv[i]);

    Str* output = goat_latin(words);
    printf("%s\n", output->body);

    strarray_free(words);
    str_free(output);
}
