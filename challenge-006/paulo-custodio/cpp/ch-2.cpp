/*
Challenge 006

Challenge #2
Create a script to calculate Ramanujan's constant with at least 32 digits of
precision. Find out more about it here.

The standard IEEE 754 double-precision binary floating-point format: binary64
gives only 15 to 17 significant decimal digits
*/

#include <iostream>
#include <gmp.h>
#include <mpfr.h>

int main() {
    mpfr_set_default_prec(256);  // 107 bits needed to represent 32 decimal digits

    mpfr_t pi, e, k;
    mpfr_inits(pi, e, k, NULL);

    mpfr_const_pi(pi, MPFR_RNDN);

    mpfr_set_str(e, "163", 10, MPFR_RNDN);  // e = 163
    mpfr_sqrt(e, e, MPFR_RNDN);             // e = sqr(163)
    mpfr_mul(e, pi, e, MPFR_RNDN);          // e = pi*sqr(163)

    mpfr_exp(k, e, MPFR_RNDN);              // k = e^(pi*sqr(163))

    mpfr_printf("%32.12Rf\n", k);           // 18.12 = 32 precision

    mpfr_clears(pi, e, k, NULL);
}
