#include "alloc.h"

const char* format_number(int n, char* buffer, size_t size) {
    // 1. Handle the end of the string
    int pos = size - 1;
    buffer[pos] = '\0';

    // 2. Handle 0 and negative numbers
    unsigned int num = (n < 0) ? -n : n;
    int count = 0;

    if (num == 0) {
        buffer[--pos] = '0';
    }
    else {
        while (num > 0 && pos > 0) {
            // Add comma every 3 digits
            if (count > 0 && count % 3 == 0) {
                buffer[--pos] = ',';
            }

            // Safety check for space before writing digit
            if (pos <= 0) break;

            buffer[--pos] = (num % 10) + '0';
            num /= 10;
            count++;
        }
    }

    // 3. Add negative sign if necessary
    if (n < 0 && pos > 0) {
        buffer[--pos] = '-';
    }

    // 4. Return the pointer to the FIRST character of the string
    return &buffer[pos];
}

int main(int argc, char*argv[]) {
    if (argc != 2)
        die("Usage: %s number", argv[0]);

    int n = atoi(argv[1]);
    char buffer[BUFSIZ];
    const char* formatted = format_number(n, buffer, sizeof(buffer));
    printf("%s\n", formatted);
}
