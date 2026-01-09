/*
Challenge 355

Task 1: Thousand Separator
Submitted by: Mohammad Sajid Anwar
You are given a positive integer, $int.

Write a script to add thousand separator, , and return as string.

Example 1
Input: $int = 123
Output: "123"

Example 2
Input: $int = 1234
Output: "1,234"

Example 3
Input: $int = 1000000
Output: "1,000,000"

Example 4
Input: $int = 1
Output: "1"

Example 5
Input: $int = 12345
Output: "12,345"
*/

#include <stdio.h>
#include <stdlib.h>

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
    if (argc != 2) {
        fputs("Usage: ch-1 number\n", stderr);
        exit(EXIT_FAILURE);
    }

    int n = atoi(argv[1]);
    char buffer[BUFSIZ];
    const char* formatted = format_number(n, buffer, sizeof(buffer));
    printf("%s\n", formatted);
}
