// Perl Weekly Challenge 227 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-227/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

typedef struct {
    const char* str;
    int value;
} Roman;

Roman roman_table[] = {
    {"M", 1000},
    {"CM", 900},
    {"D", 500},
    {"CD", 400},
    {"C", 100},
    {"XC", 90},
    {"L", 50},
    {"XL", 40},
    {"X", 10},
    {"IX", 9},
    {"V", 5},
    {"IV", 4},
    {"I", 1},
    {NULL, 0},
};

#define MAX_ROMAN 3999

enum { PLUS, MINUS, MUL, DIV, POWER };

int ipow(int base, int exp) {
    int result = 1;
    for (;;) {
        if (exp & 1)
            result *= base;
        exp >>= 1;
        if (!exp)
            break;
        base *= base;
    }

    return result;
}

int roman_to_int(const char* roman) {
    int value = 0;
    for (const char* p = roman; *p; ) {
        // check each digit
        bool found = false;
        for (Roman* t = roman_table; !found && t->str != NULL; t++) {
            if (strncmp(p, t->str, strlen(t->str)) == 0) {
                value += t->value;
                p += strlen(t->str);
                found = true;
            }
        }
        if (!found)
            die("invalid character '%c' in roman numeral '%s'", *p, roman);
    }
    return value;
}

Str* int_to_roman(int num) {
    Str* roman = str_new();
    if (num < 0 || num > MAX_ROMAN)
        str_append(roman, "non potest");
    else if (num == 0)
        str_append(roman, "nulla");
    else {
        while (num > 0) {
            for (Roman* t = roman_table; t->str != NULL; t++) {
                while (num >= t->value) {
                    str_append(roman, t->str);
                    num -= t->value;
                }
            }
        }
        assert(num == 0);
    }
    return roman;
}

char* scan_roman(const char** p) {
    while (isspace(**p))
        (*p)++;
    const char* start = *p;
    while (strchr("MDCLXVI", **p) != NULL)
        (*p)++;
    if (*p > start)
        return xstrndup(start, *p - start);
    else
        return NULL;
}

int scan_operator(const char** p) {
    while (isspace(**p))
        (*p)++;
    if (strncmp(*p, "**", 2) == 0) {
        (*p) += 2;
        return POWER;
    }
    else if (**p == '+') {
        (*p)++;
        return PLUS;
    }
    else if (**p == '-') {
        (*p)++;
        return MINUS;
    }
    else if (**p == '*') {
        (*p)++;
        return MUL;
    }
    else if (**p == '/') {
        (*p)++;
        return DIV;
    }
    else {
        die("invalid operator '%c'", **p);
        return -1;
    }
}

Str* calc(const char* expr) {
    const char* p = expr;

    char* op1 = scan_roman(&p);
    if (op1 == NULL)
        die("invalid expression '%s'", expr);
    int n1 = roman_to_int(op1);
    xfree(op1);

    int op = scan_operator(&p);
    if (op < 0)
        die("invalid expression '%s'", expr);

    char* op2 = scan_roman(&p);
    if (op2 == NULL)
        die("invalid expression '%s'", expr);
    int n2 = roman_to_int(op2);
    xfree(op2);

    switch (op) {
    case PLUS:
        return int_to_roman(n1 + n2);
    case MINUS:
        return int_to_roman(n1 - n2);
    case MUL:
        return int_to_roman(n1 * n2);
    case DIV:
        if (n2 == 0)
            return int_to_roman(-1);    // not possible to compute
        else if ((n1/n2)*n2 != n1)
            return int_to_roman(-1);    // not integer
        else
            return int_to_roman(n1 / n2);
    case POWER:
        return int_to_roman(ipow(n1, n2));
    default:
        assert(0);
    }

    return NULL;        // not reached
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s roman-expression", argv[0]);

    Str* args = str_new();
    for (int i = 1; i < argc; i++)
        str_printf(args, "%s ", argv[i]);
    Str* result = calc(args->body);
    printf("%s\n", result->body);
    str_free(args);
    str_free(result);
}
