#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int parse_year(const char* str) {
    return atoi(str);
}

int parse_month(const char* str) {
    static const char* months = "JanFebMarAprMayJunJulAugSepOctNovDec";
    const char* found = strstr(months, str);
    if (found == NULL) {
        fprintf(stderr, "Invalid month: %s\n", str);
        exit(EXIT_FAILURE);
    }
    int month = (found - months) / 3 + 1;
    return month;
}

int parse_day(const char* str) {
    return atoi(str);
}

int main(int argc, char* argv[]) {
    if (argc != 4) {
        fprintf(stderr, "usage: %s day month year\n", argv[0]);
        return EXIT_FAILURE;
    }

    int day = parse_day(argv[1]);
    int month = parse_month(argv[2]);
    int year = parse_year(argv[3]);

    printf("%04d-%02d-%02d\n", year, month, day);
}
