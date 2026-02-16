#include "alloc.h"

int find_discount(int price, IntArray* prices, int first_index) {
    for (int i = first_index; i < prices->size; i++) {
        if (prices->data[i] <= price)
            return prices->data[i];
    }
    return 0;
}

void compute_discounts(IntArray* prices) {
    for (int i = 0; i < prices->size; i++) {
        int discount = find_discount(prices->data[i], prices, i+1);
        prices->data[i] -= discount;
    }
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s prices", argv[0]);

    IntArray* prices = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(prices, atoi(argv[i]));
    compute_discounts(prices);
    intarray_print(prices);
    intarray_free(prices);
}
