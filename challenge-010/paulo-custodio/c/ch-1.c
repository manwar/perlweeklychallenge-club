/*
Challenge 010

Challenge #1
Write a script to encode/decode Roman numerals. For example, given Roman
numeral CCXLVI, it should return 246. Similarly, for decimal number 39, it
should return XXXIX. Checkout wikipedia page for more information.
*/

#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#define MAXLINE 1024

int decode_roman(const char* str) {
    int num = 0;
    for (const char* p = str; *p; p++) {
        switch (*p) {
        case 'M': num += 1000; break;
        case 'D': num += 500; break;
        case 'C':
            if (p[1] == 'D') { num += 400; p++; }
            else if (p[1] == 'M') { num += 900; p++; }
            else { num += 100; }
            break;
        case 'L': num += 50; break;
        case 'X':
            if (p[1] == 'L') { num += 40; p++; }
            else if (p[1] == 'C') { num += 90; p++; }
            else { num += 10; }
            break;
        case 'V': num += 5; break;
        case 'I':
            if (p[1] == 'V') { num += 4; p++; }
            else if (p[1] == 'X') { num += 9; p++; }
            else { num += 1; }
            break;
        default:
            fprintf(stderr, "invalid roman numeral %c\n", *p);
            exit(EXIT_FAILURE);
        }
    }
    return num;
}

char* encode_roman(char* buffer, int num) {
    buffer[0] = '\0';
    while (num >= 1000) { strcat(buffer, "M"); num -= 1000; }
    if (num >= 900) { strcat(buffer, "CM"); num -= 900; }
    if (num >= 500) { strcat(buffer, "D"); num -= 500; }
    if (num >= 400) { strcat(buffer, "CD"); num -= 400; }
    while (num >= 100) { strcat(buffer, "C"); num -= 100; }
    if (num >= 90) { strcat(buffer, "XC"); num -= 90; }
    if (num >= 50) { strcat(buffer, "L"); num -= 50; }
    if (num >= 40) { strcat(buffer, "XL"); num -= 40; }
    while (num >= 10) { strcat(buffer, "X"); num -= 10; }
    if (num >= 9) { strcat(buffer, "IX"); num -= 9; }
    if (num >= 5) { strcat(buffer, "V"); num -= 5; }
    if (num >= 4) { strcat(buffer, "IV"); num -= 4; }
    while (num >= 1) { strcat(buffer, "I"); num--; }
    return buffer;
}

int main(int argc, char* argv[]) {
    char str[MAXLINE];

    if (argc != 2) return EXIT_FAILURE;
    if (strcmp(argv[1], "-test") == 0) {
        for (int i = 1; i <= 3000; i++) {
            int num = decode_roman(encode_roman(str, i));
            assert(num == i);
        }
    }
    else if(isdigit(argv[1][0])) {
        int num = atoi(argv[1]);
        encode_roman(str, num);
        printf("%d => %s\n", num, str);
    }
    else {
        int num = decode_roman(argv[1]);
        printf("%s => %d\n", argv[1], num);
    }
}
