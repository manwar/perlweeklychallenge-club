// Perl Weekly Challenge 236 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-236/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

#define PRICE 5

bool make_sell(int bill, IntArray* cash) {
    intarray_push_back(cash, bill);
    int change = bill - PRICE;
    while (change > 0 && cash->size > 0) {
        intarray_sort(cash);
        bool found_change = false;
        for (int i = cash->size-1; i >= 0 && !found_change; i--) {
            if (cash->data[i] <= change) {
                change -= cash->data[i];
                intarray_erase(cash, i);
                found_change = true;
            }
        }
        if (!found_change)
            break;
    }
    return change == 0;
}

bool can_give_change(IntArray* bills) {
    IntArray* cash = intarray_new();
    for (int i = 0; i < bills->size; i++) {
        if (!make_sell(bills->data[i], cash)) {
            intarray_free(cash);
            return false;
        }
    }
    intarray_free(cash);
    return true;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s bills...", argv[0]);

    IntArray* bills = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(bills, atoi(argv[i]));

    bool ok = can_give_change(bills);
    printf("%s\n", bool_to_string(ok));

    intarray_free(bills);
}
