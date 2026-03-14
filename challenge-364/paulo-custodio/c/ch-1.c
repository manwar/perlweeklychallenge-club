#include "../../../challenge-001/paulo-custodio/c/alloc.h"

void encode_words(StrArray* words) {
    for (int i = 0; i < words->size; i++) {
        Str* encoded = str_new();
        for (int j = 0; j < strlen(words->data[i]); j++) {
            char c = tolower(words->data[i][j]);
            if (isalpha(c))
                str_printf(encoded, "%d%s", c - 'a' + 1, (c > 'i' ? "#" : ""));
        }
        xfree(words->data[i]);
        words->data[i] = xstrdup(encoded->body);
        str_free(encoded);
    }
}

void decode_words(StrArray* words) {
    for (int i = 0; i < words->size; i++) {
        Str* decoded = str_new();
        for (const char* p = words->data[i]; *p; p++) {
            if (isdigit(p[0]) && p[1] && isdigit(p[1]) && p[2] && p[2] == '#') {
                str_printf(decoded, "%c", atoi(p) + 'a' - 1);
                p += 2; // skip the two digits
            }
            else if (isdigit(p[0])) {
                str_printf(decoded, "%c", p[0] - '0' + 'a' - 1);
            }
        }
        xfree(words->data[i]);
        words->data[i] = xstrdup(decoded->body);
        str_free(decoded);
    }
}
int main(int argc, char *argv[]) {
    bool encode = false;
    int arg = 1;
    if (arg < argc && strcmp(argv[arg],"-e")==0) {
        encode = true;
        arg++;
    }
    if (arg >= argc)
        die("usage: %s [-e] words...", argv[0]);

    StrArray* words = strarray_new();
    for (int i = arg; i < argc; i++)
        strarray_push_back(words, argv[i]);

    if (encode)
        encode_words(words);
    else
        decode_words(words);

    for (int i = 0; i < words->size; i++) {
        if (i > 0)
            printf(" ");
        printf("%s", words->data[i]);
    }
    printf("\n");

    strarray_free(words);
}
