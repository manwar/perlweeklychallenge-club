#include "alloc.h"
#include <math.h>

#define Epsilon 1e-9

typedef struct {
    int numer;
    int denom;
    double value;
} Fraction;

Fraction* fractions = NULL;
size_t fraction_count = 0;

void append_fraction(int numer, int denom) {
    fractions = xrealloc(fractions, (fraction_count + 1) * sizeof(Fraction));

    fractions[fraction_count].numer = numer;
    fractions[fraction_count].denom = denom;
    fractions[fraction_count].value = (double)numer / denom;
    fraction_count++;
}

bool find_fraction(int numer, int denom) {
    double value = (double)numer / denom;
    for (size_t i = 0; i < fraction_count; i++) {
        if (fabs(fractions[i].value - value) < Epsilon) {
            return true;
        }
    }
    return false;
}

void generate_fractions(int n) {
    for (int denom = 1; denom <= n; denom++) {
        for (int numer = 1; numer <= n; numer++) {
            if (!find_fraction(numer, denom)) {
                append_fraction(numer, denom);
            }
        }
    }
}

int compare_fractions(const void* a, const void* b) {
    Fraction* frac_a = (Fraction*)a;
    Fraction* frac_b = (Fraction*)b;
    if (frac_a->value < frac_b->value) return -1;
    if (frac_a->value > frac_b->value) return 1;
    return 0;
}

void sort_fractions() {
    qsort(fractions, fraction_count, sizeof(Fraction), compare_fractions);
}

void print_fractions() {
    const char* separator = "";
    for (size_t i = 0; i < fraction_count; i++) {
        printf("%s%d/%d", separator, fractions[i].numer, fractions[i].denom);
        separator = ", ";
    }
    printf("\n");
}

int main(int argc, char* argv[]) {
    if (argc != 2)
        die("Usage: %s n", argv[0]);

    generate_fractions(atoi(argv[1]));
    sort_fractions();
    print_fractions();
}
