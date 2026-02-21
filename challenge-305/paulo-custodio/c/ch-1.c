#include "alloc.h"

bool is_prime(int n) {
    if (n < 2)
        return false;
    if (n == 2)
        return true;
    if (n % 2 == 0)
        return false;
    for (int i = 3; i*i <= n; i+= 2) {
        if (n % i == 0)
            return false;
    }
    return true;
}

int calc_bin_prefix(IntArray* bin, int len) {
    int n = 0;
    for (int i = 0; i < bin->size && i < len; i++) {
        n = 2*n + bin->data[i];
    }
    return n;
}

IntArray* get_bin_prefix(IntArray* bin) {
    IntArray* bin_prefix = intarray_new();
    for (int len = 1; len <= bin->size; len++) {
        int n = calc_bin_prefix(bin, len);
        bool p = is_prime(n);
        intarray_push_back(bin_prefix, p);
    }
    return bin_prefix;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s bin...", argv[0]);

    IntArray* bin = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(bin, atoi(argv[i]));

    IntArray* bin_prefix = get_bin_prefix(bin);

    printf("(");
    const char* separator = "";
    for (int i = 0; i < bin_prefix->size; i++) {
        printf("%s%s", separator, bool_to_string(bin_prefix->data[i]));
        separator = ", ";
    }
    printf(")\n");

    intarray_free(bin);
    intarray_free(bin_prefix);
}
