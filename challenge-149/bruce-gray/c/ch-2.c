// Adapted from Python+gmpy2 code at https://oeis.org/A287298
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>
#include "gmp.h"

#define MAX_BASE 62

char digits[MAX_BASE+2];        // Never using more
char repetitions_array[128];    // max ord of '9','Z','z' is 122
mpz_t m1;
mpz_t mpz_square;
mpz_t initial_all_digits;

int
has_no_repeating_digits(char *s) {
    memset(repetitions_array, 0, sizeof(repetitions_array));
    unsigned char *c;
    for (c = (unsigned char *) s ; c[0] != '\0' ; c++) {
        if (repetitions_array[ c[0] ])
            return 0;
        repetitions_array[ c[0] ] = 1;
    }
    return 1;
}

int
square_has_no_repeating_digits(const mpz_t i, int base) {
    mpz_mul(mpz_square, i, i);
    mpz_get_str(digits, base, mpz_square);

    return has_no_repeating_digits(digits);
}

void
set_all_digits_descending(mpz_t m, int base) {
    int digit;
    // e.g. For base=5, initial_all_digits will be 43210
    mpz_set_ui(m, 0);
    for (digit = base - 1 ; digit >= 0 ; digit--) {
        mpz_add_ui(m, m, digit);
        mpz_mul_ui(m, m, base);
    }
    mpz_divexact_ui(m, m, base);
}

mpz_t*
A287298(int base) {
    assert(base <= 62);
    assert(base >=  2);

    set_all_digits_descending(m1, base);
    for ( mpz_sqrt(m1, m1) ; mpz_cmp_si(m1, 0) > 0 ; mpz_sub_ui(m1, m1, 1) ) {
        if (square_has_no_repeating_digits(m1, base))
            return &m1;
    }
    assert(1 == 0);  // Should not ever hit this point!
}

int
main(int argc, char **argv) {
    int i;
    assert(argc > 1);

    mpz_init(m1);
    mpz_init(mpz_square);
    mpz_init(initial_all_digits);

    for (i = 1 ; i < argc ; i++) {
        int base = atoi(argv[i]);
        mpz_t *r = A287298(base);
        mpz_mul(mpz_square, *r, *r);
        printf("f(%d)='%s'\n", base, mpz_get_str(NULL, base, mpz_square));
    }

    return 0;
}
