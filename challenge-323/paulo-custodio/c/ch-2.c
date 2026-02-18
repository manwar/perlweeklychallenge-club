#include "alloc.h"
#include <math.h>

double compute_tax() {
    char line[BUFSIZ];
    if (!fgets(line, sizeof(line), stdin))
        die("insufficient data");

    double income = 0.0;
    if (sscanf(line, "%lf", &income) != 1)
        die("insufficient data");

    double tax = 0.0;
    double base = 0.0;

    while (fgets(line, sizeof(line), stdin)) {
        double bracket = 0.0;
        double tax_rate = 0.0;
        if (sscanf(line, "%lf %lf", &bracket, &tax_rate) != 2)
            die("invalid data");

        if (income <= base)
            break;

        double taxable = MIN(income - base, bracket - base);
        double bracket_tax = taxable * tax_rate / 100.0;
        tax += bracket_tax;
        base = bracket;
    }

    return tax;
}

int main() {
    double tax = compute_tax();
    if (fabs(tax) < Epsilon)
        printf("0\n");
    else
        printf("%.2lf\n", tax);
}
