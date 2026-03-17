#include "../../../challenge-001/paulo-custodio/c/alloc.h"

int sum_digits(const char* str) {
    int sum = 0;
    for (const char* p = str; *p; p++) {
        if (isdigit(*p))
            sum += *p - '0';
    }
    return sum;
}

int compute(const char* str, int k) {
    Str* digits = str_new();
    for (const char* p = str; *p; p++) {
        if (*p >= 'a' && *p <= 'z')
            str_printf(digits, "%d", *p - 'a' + 1);
    }

    int sum = sum_digits(digits->body);
    while (k-- > 0) {
        str_clear(digits);
        str_printf(digits, "%d", sum);
        sum = sum_digits(digits->body);
    }

    str_free(digits);
    return sum;
}

int main(int argc, char* argv[]) {
    if (argc != 3)
        die("usage: %s string k", argv[0]);

    int sum = compute(argv[1], atoi(argv[2]));
    printf("%d\n", sum);
}
