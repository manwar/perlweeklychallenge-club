// Perl Weekly Challenge 178 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-178/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

int ipow(int base, int exp) {
    assert(exp >= 0);
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

Str* decimal_to_basei(int n) {
    Str* result1 = str_new();
    Str* result2 = str_new();
    int base = -4;
    while (n != 0) {
        int i = n % base;
        n /= base;
        if (i < 0) {
            i += abs(base);
            n++;
        }
        str_clear(result2);
        str_printf(result2, "0%d%s", i, result1->body);
        SWAP(Str*, result1, result2);
    }
    char* p = result1->body;
    while (*p == '0')
        p++;
    str_clear(result2);
    str_append(result2, p);
    SWAP(Str*, result1, result2);

    str_free(result2);
    return result1;
}

int base2i_to_decimal(const char* n2i) {
    int base = -4;
    int result = 0;
    for (int i = strlen(n2i)-1; i >= 0; i--) {
        int order = strlen(n2i)-1-i;
        if (order % 2 == 0) {       // real part
            result += (n2i[i] - '0') * ipow(base, order/2);
        }
        else if (n2i[i] != '0') {   // imaginary part
            die("number %s has imaginary part", n2i);
        }
    }
    return result;
}

int main(int argc, char* argv[]) {
    if (argc == 3 && strcmp(argv[1], "dec_to_base2i") == 0) {
        Str* result = decimal_to_basei(atoi(argv[2]));
        printf("%s\n", result->body);
        str_free(result);
    }
    else if (argc == 3 && strcmp(argv[1], "base2i_to_dec") == 0) {
        int result = base2i_to_decimal(argv[2]);
        printf("%d\n", result);
    }
    else {
        die("usage: %s dec_to_base2i|base2i_to_dec n", argv[0]);
    }
}
