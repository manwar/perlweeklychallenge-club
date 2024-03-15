#include <stdio.h>
#include <mpfr.h>

int main() {
  mpfr_t s, pi;

  mpfr_init2(pi, 130);
  mpfr_const_pi(pi, MPFR_RNDN);
  
  mpfr_init2(s, 130);
  mpfr_set_d(s, 163, MPFR_RNDD);
  mpfr_sqrt(s, s, MPFR_RNDD);

  mpfr_mul(s, s, pi, MPFR_RNDU);
  mpfr_exp(s, s, MPFR_RNDD);
  mpfr_printf("%.32Rf\n", s);

  mpfr_clear(s);
  mpfr_clear(pi);
  mpfr_free_cache();
}

