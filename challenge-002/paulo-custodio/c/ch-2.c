/*
Challenge 002

Challenge #2
Write a script that can convert integers to and from a base35
representation, using the characters 0-9 and A-Y. Dave Jacoby came up
with nice description about base35, in case you needed some background.
*/

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <memory.h>
#include <string.h>
#include <ctype.h>

void* check_mem(void* p) {
    if (!p) {
        fputs("out of memory", stderr);
        exit(EXIT_FAILURE);
    }
    return p;
}

// format a digit
char format_digit(int n) {
    if (n < 10)
        return '0' + n;
    else
        return 'A' + n - 10;
}

// format a number - user must free buffer
char* format_number(int n, int base) {
    bool negative = false;
    char* str = check_mem(strdup(""));
    if (n < 0) {
        negative = true;
        n = -n;
    }
    do {
        int d = n % base;
        n = n / base;
        str = check_mem(realloc(str, strlen(str) + 2));
        memmove(str + 1, str, strlen(str) + 1);
        str[0] = format_digit(d);
    } while (n > 0);
    if (negative) {
        str = check_mem(realloc(str, strlen(str) + 2));
        memmove(str + 1, str, strlen(str) + 1);
        str[0] = '-';
    }
    return str;
}

// scan digit
int scan_digit(char c) {
    if (isdigit(c))
        return c - '0';
    else if (isalpha(c))
        return toupper(c) - 'A' + 10;
    else
        return -1;
}

// scan number
int scan_number(const char* p, int base) {
    bool negative = false;
    int n = 0;
    if (*p == '-') {
        negative = true;
        p++;
    }
    while (*p != '\0') {
        int d = scan_digit(*p++);
        if (d < 0 || d >= base) {
            fputs("invalid number", stderr);
            exit(EXIT_FAILURE);
        }
        n = n * base + d;
    }
    if (negative)
        n = -n;
    return n;
}

int main(int argc, char* argv[]) {
    if (argc == 2) {
        char* num = format_number(atoi(argv[1]), 35);
        puts(num);
        free(num);
    }
    else if (argc == 3 && strcmp(argv[1], "-r") == 0) {
        printf("%d\n", scan_number(argv[2], 35));
    }
    else {
        fputs("Usage: ch-2 [-r] number", stderr);
        return EXIT_FAILURE;
    }
}
