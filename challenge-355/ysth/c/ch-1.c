
// https://theweeklychallenge.org/blog/perl-weekly-challenge-355/#TASK1

#include <inttypes.h>
#include <locale.h>
#include <stdio.h>
#include <stdlib.h>

#define LOCALE "en_US.utf8"

char *thousand_separator(uintmax_t i) {

    char *oldlocale = setlocale(LC_NUMERIC, NULL);
    if (NULL == setlocale(LC_NUMERIC, LOCALE)) {
        fprintf(stderr, "Unable to set locale to %s\n", LOCALE);
        exit(EXIT_FAILURE);
    }
    size_t required_characters = 1 + (size_t)snprintf(NULL, 0, "%'" PRIuMAX, i);
    char *result = malloc(required_characters);
    snprintf(result, required_characters, "%'" PRIuMAX, i);
    setlocale(LC_NUMERIC, oldlocale);

    return result;
}

#include <ctype.h>

int main(int argc, char *argv[]) {
    for (char **arg = argv+1; arg < argv+argc; ++arg) {
        printf("Inputs: %s\n", *arg);

        char *endptr;
        uintmax_t i = strtoumax(*arg, &endptr, 10);
        if (isspace(**arg) || *endptr != '\0') {
            printf("Exception: expected a nonnegative integer, got '%s'\n", *arg);
            continue;
        }

        char *result = thousand_separator(i);
        printf("Output: \"%s\"\n", result);
        free(result);
    }

    return EXIT_SUCCESS;
}
