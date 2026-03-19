// Perl Weekly Challenge 231 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-231/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

#define ELDERLY 60

int extract_age(const char* record) {
    if (strlen(record) < 13)
        return -1;

    char age[3];
    strncpy(age, record+11, 2);
    age[2] = '\0';
    return atoi(age);
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s record...", argv[0]);

    int count = 0;
    for (int i = 1; i < argc; i++) {
        int age = extract_age(argv[i]);
        if (age >= ELDERLY)
            count++;
    }
    printf("%d\n", count);
}
