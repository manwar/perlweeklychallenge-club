#include "alloc.h"

void remove_non_digits(char* text) {
    int write = 0;
    for (int read = 0; text[read] != '\0'; read++) {
        if (isdigit(text[read]))
            text[write++] = text[read];
    }
    text[write] = '\0';
}

bool is_luhn(const char* digits) {
    int len = strlen(digits);
    if (len < 2)
        return false;

    int payload = digits[len-1] - '0';

    int sum = 0;
    int factor = 2;
    for (int i = len-2; i >= 0; i--) {
        int digit = factor * (digits[i] - '0');
        if (digit > 9)
            sum += digit / 10;
        sum += digit % 10;
        factor = 3 - factor;
    }

    return (sum + payload) % 10 == 0;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s digits...", argv[0]);

    Str* digits = str_new();
    for (int i = 1; i < argc; i++)
        str_append(digits, argv[i]);

    remove_non_digits(digits->body);
    bool ok = is_luhn(digits->body);
    printf("%s\n", bool_to_string(ok));

    str_free(digits);
}
