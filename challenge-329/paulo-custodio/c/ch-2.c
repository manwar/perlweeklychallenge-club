#include <assert.h>
#include <ctype.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool is_nice_string(const char* str, int start, int len) {
    bool count[UCHAR_MAX] = {false};

    // count letters
    for (int i = start; i < start+len; i++) {
        count[str[i]] = true;
    }

    // check if all lettes have lower case and upper case
    for (int i = start; i < start+len; i++) {
        if (! count[tolower(str[i])] ||
            ! count[toupper(str[i])])
            return false;
    }

    return true;
}

char* nice_substring(const char* str) {
    int len = strlen(str);
    for (int i = 0; i < len; i++) {
        for (int sublen = len-i; sublen > 0; sublen--) {
            if (is_nice_string(str, i, sublen)) {
                char* result = malloc(sublen+1);
                assert(result);
                strncpy(result, str+i, sublen);
                result[sublen] = '\0';
                return result;
            }
        }
    }

    char* result = strdup("");
    assert(result);
    return result;
}

int main(int argc, char* argv[]) {
    if (argc != 2) {
        fprintf(stderr, "usage: %s string\n", argv[0]);
        return EXIT_FAILURE;
    }

    char* result = nice_substring(argv[1]);
    printf("%s\n", result);
    free(result);
}
