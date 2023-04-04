/*
Challenge 016

Task #2
Write a script to validate a given bitcoin address. Most Bitcoin addresses
are 34 characters. They consist of random digits and uppercase and lowercase
letters, with the exception that the uppercase letter “O”, uppercase letter “I”,
lowercase letter “l”, and the number “0” are never used to prevent visual
ambiguity. A bitcoin address encodes 25 bytes. The last four bytes are a
checksum check. They are the first four bytes of a double SHA-256 digest
of the previous 21 bytes. For more information, please refer wiki page.
Here are some valid bitcoin addresses:

    1BvBMSEYstWetqTFn5Au4m4GFg7xJaNVN2
    3J98t1WpEZ73CNmQviecrnyiWrnqRhWNLy
*/


#include <assert.h>
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>
#include <string.h>

// uses sha256 from https://github.com/B-Con/crypto-algorithms
// to integrate with test infrastructure needs one single source ch-2.c
// therefore include sha256.c
#include "sha256.c"

#define BASE58          58
#define BTC_ADDR_SIZE   25
#define CHECKSUM_SIZE   4

const char* B58_DIGITS = "123456789" \
"ABCDEFGHJKLMNPQRSTUVWXYZ" \
"abcdefghijkmnopqrstuvwxyz";

void* check_mem(void* p) {
    if (!p) {
        fputs("out of memory", stderr);
        exit(EXIT_FAILURE);
    }
    return p;
}

int decode_b58_digit(char c) {
    if (!isalnum(c))
        return -1;
    const char* p = strchr(B58_DIGITS, c);
    if (p == NULL)
        return -1;
    else
        return (int)(p - B58_DIGITS);
}

bool decode_b58(uint8_t* result, size_t result_size, const char* code) {
    int* values = check_mem(calloc(result_size, sizeof(int)));

    // decode each digit
    for (const char* p = code; *p; p++) {
        int digit = decode_b58_digit(*p);
        if (digit < 0) {
            free(values);
            return false;
        }

        // multiply all bytes by base and add digit
        for (int i = (int)result_size - 1; i >= 0; i--)
            values[i] *= BASE58;

        int carry = digit;
        for (int i = (int)result_size - 1; i >= 0; i--) {
            values[i] += carry;
            carry = 0;

            if (values[i] > 0xff) {
                carry = values[i] >> 8;
                values[i] &= 0xff;
            }
        }

        if (carry != 0) {           // size too short for value
            free(values);
            return false;
        }
    }

    // convert values to bytes
    for (int i = 0; i < result_size; i++)
        result[i] = (uint8_t)values[i];

    free(values);
    return true;
}

bool is_btc_address_valid(const char* str) {
    // check prefix
    if (str[0] != '1' && str[0] != '3' && strncmp(str, "bc1", 3) != 0)
        return false;

    // decode address
    uint8_t addr[BTC_ADDR_SIZE];
    if (!decode_b58(addr, BTC_ADDR_SIZE, str))
        return false;

    // compute checksum
    uint8_t buf1[SHA256_BLOCK_SIZE];
    SHA256_CTX ctx1;
    sha256_init(&ctx1);
    sha256_update(&ctx1, addr, BTC_ADDR_SIZE - CHECKSUM_SIZE);
    sha256_final(&ctx1, buf1);

    uint8_t buf2[SHA256_BLOCK_SIZE];
    SHA256_CTX ctx2;
    sha256_init(&ctx2);
    sha256_update(&ctx2, buf1, SHA256_BLOCK_SIZE);
    sha256_final(&ctx2, buf2);

    if (memcmp(buf2, addr + BTC_ADDR_SIZE - CHECKSUM_SIZE, CHECKSUM_SIZE) == 0)
        return true;
    else
        return false;
}

int main(int argc, char* argv[]) {
    if (argc != 2) {
        fputs("usage: ch-2 address", stderr);
        return EXIT_FAILURE;
    }

    printf("%d\n", is_btc_address_valid(argv[1]) ? 1 : 0);
}
