#include "../../../challenge-001/paulo-custodio/c/alloc.h"

bool is_vowel(char ch) {
    ch = tolower(ch);
    return ch=='a'||ch=='e'||ch=='i'||ch=='o'||ch=='u';
}

char* reverse_vowels(const char* str) {
    char* result = xstrdup(str);

    // reverse vowels
    int b = 0;
    int t = strlen(result)-1;
    while (true) {
        while (result[b] != '0' && !is_vowel(result[b]))
            b++;
        while (t > 0 && !is_vowel(result[t]))
            t--;
        if (b >= t)
            break;
        if (!is_vowel(result[b]))
            break;
        if (!is_vowel(result[t]))
            break;
        SWAP(char, result[b], result[t]);
        b++;
        t--;
    }

    // noralize case
    for (int i = 0; result[i] != '\0'; i++) {
        if (i == 0)
            result[i] = toupper(result[i]);
        else
            result[i] = tolower(result[i]);
    }

    return result;
}

int main(int argc, char* argv[]) {
    if (argc != 2)
        die("usage: %s word", argv[0]);

    char* result = reverse_vowels(argv[1]);
    printf("%s\n", result);
    xfree(result);
}
