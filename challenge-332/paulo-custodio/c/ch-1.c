#include "alloc.h"

#define BIN_SIZE 64

void dec_to_bin(char* dest, int value) {
    char digits[BIN_SIZE];
    char* dp = digits;
    do {
        char bit = (value & 1) ? '1' : '0';
        value >>= 1;
        *dp++ = bit;
    } while (value);

    char* destp = dest;
    while (dp-1 >= digits)
        *destp++ = *(--dp);
    *destp = '\0';
}

int main(int argc, char* argv[]) {
    if (argc != 2)
        die("usage: %s yyyy-mm-dd", argv[0]);

    int y = 0, m = 0, d = 0;
    if (sscanf(argv[1], "%d-%d-%d", &y, &m, &d) != 3)
        die("invalid date format: %s", argv[1]);

    char yy[BIN_SIZE], mm[BIN_SIZE], dd[BIN_SIZE];
    dec_to_bin(yy, y);
    dec_to_bin(mm, m);
    dec_to_bin(dd, d);

    printf("%s-%s-%s\n", yy, mm, dd);
}
