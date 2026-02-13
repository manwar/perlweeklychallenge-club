#include "alloc.h"
#include <ctype.h>

int compare (const void* a, const void* b) {
    return *(char*)a - *(char*)b;
}

char* balance_string(const char* str) {
    // allocate memory
    char* letters = xmalloc(strlen(str) + 1);
    letters[0] = '\0';
    char* lp = letters;

    char* digits = xmalloc(strlen(str) + 1);
    digits[0] = '\0';
    char* dp = digits;

    char* result = xmalloc(strlen(str) + 1);
    result[0] = '\0';
    char* rp = result;

    // copy letters and digits
    for (int i = 0; str[i] != '\0'; i++) {
        if (isdigit(str[i]))
            *dp++ = str[i];
        else if (isalpha(str[i]))
            *lp++ = str[i];
        else {
            fprintf(stderr, "invalid character: '%c'\n", str[i]);
            exit(EXIT_FAILURE);
        }
    }
    *lp = '\0';
    *dp = '\0';

    // compare lengths of letters and digits
    int letters_len = lp - letters;
    int digits_len = dp - digits;
    if (abs(letters_len - digits_len) > 1) {
        // no solution
        free(letters);
        free(digits);
        return result;
    }

    // sort the letters and digits
    qsort(letters, letters_len, sizeof(char), compare);
    qsort(digits, digits_len, sizeof(char), compare);

    // start with the longest string
    const char* p1 = letters_len >  digits_len ? letters : digits;
    const char* p2 = letters_len <= digits_len ? letters : digits;

    // copy from the pools to the result
    while (*p1 != '\0' || *p2 != '\0') {
        if (*p1 != '\0') {
            *rp++ = *p1++;
        }
        if (*p2 != '\0') {
            *rp++ = *p2++;
        }
    }
    *rp = '\0';

    xfree(letters);
    xfree(digits);
    return result;
}

int main(int argc, char* argv[]) {
    if (argc != 2)
        die("usage: %s str", argv[0]);

    char* balanced = balance_string(argv[1]);
    printf("%s\n", balanced);
    xfree(balanced);
}
