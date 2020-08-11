#include <ctype.h>
#include <stdlib.h>
#include <string.h>

char *rot13(char *s) {
    const size_t s_len = strlen(s);
    char *result = malloc((s_len + 1) * sizeof(char));

    for (size_t i = 0; i < s_len; i++) {
        if (isalpha(s[i])) {
            if ((tolower(s[i]) - 'a') < 13) {
                result[i] = s[i] + 13;
            } else {
                result[i] = s[i] - 13;
            }
        } else {
            result[i] = s[i];
        }
    }

    result[s_len] = '\0';

    return result;
}
