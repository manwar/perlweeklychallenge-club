// Perl Weekly Challenge 167 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-167/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

#define EPS 1e-14

// Lanczos coefficients (g = 7, n = 9)
static const double g = 7.0;
static const double p[] = {
    0.99999999999980993,
    676.5203681218851,
   -1259.1392167224028,
    771.32342877765313,
   -176.61502916214059,
     12.507343278686905,
     -0.13857109526572012,
      9.9843695780195716e-6,
      1.5056327351493116e-7
};

static bool is_integer(double x) {
    return fabs(x - round(x)) < EPS;
}

double gamma_lanczos(double z) {

    // Poles of Gamma function
    if (z <= 0.0 && is_integer(z)) {
        return NAN; // G(z) undefined
    }

    // Reflection formula for z < 0.5
    if (z < 0.5) {
        double s = sin(M_PI * z);
        if (fabs(s) < EPS) {
            return NAN; // numerical singularity
        }
        return M_PI / (s * gamma_lanczos(1.0 - z));
    }

    // Lanczos approximation for z >= 0.5
    z -= 1.0;

    double x = p[0];
    for (int i = 1; i < 9; i++) {
        x += p[i] / (z + i);
    }

    double t = z + g + 0.5;

    return sqrt(2.0 * M_PI)
         * pow(t, z + 0.5)
         * exp(-t)
         * x;
}

int main(int argc, char* argv[]) {
    if (argc != 2)
        die("usage: %s n", argv[0]);

    printf("%d\n", (int)round(gamma_lanczos(atof(argv[1]))));
}
