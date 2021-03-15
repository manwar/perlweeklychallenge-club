/*
Challenge 002

Challenge #2
Write a script that can convert integers to and from a base35
representation, using the characters 0-9 and A-Y. Dave Jacoby came up
with nice description about base35, in case you needed some background.
*/

#include <iostream>
#include <string>
#include <cctype>

// format a digit
char format_digit(int n) {
    if (n < 10)
        return '0' + n;
    else
        return 'A' + n - 10;
}

// format a number
std::string format_number(int n, int base) {
    bool negative = false;
    std::string str;
    if (n < 0) {
        negative = true;
        n = -n;
    }
    do {
        int d = n % base;
        n = n / base;
        str.insert(0, 1, format_digit(d));
    } while (n > 0);
    if (negative)
        str.insert(0, 1, '-');
    return str;
}

// scan digit
int scan_digit(char c) {
    if (isdigit(c))
        return c - '0';
    else if (isalpha(c))
        return toupper(c) - 'A' + 10;
    else
        return -1;
}

// scan number
int scan_number(const std::string& str, int base) {
    const char* p = str.c_str();
    bool negative = false;
    int n = 0;
    if (*p == '-') {
        negative = true;
        p++;
    }
    while (*p != '\0') {
        int d = scan_digit(*p++);
        if (d < 0 || d >= base) {
            std::cerr << "invalid number" << std::endl;
            exit(EXIT_FAILURE);
        }
        n = n * base + d;
    }
    if (negative)
        n = -n;
    return n;
}

int main(int argc, char* argv[]) {
    if (argc == 2)
        std::cout << format_number(atoi(argv[1]), 35) << std::endl;
    else if (argc == 3 && std::string(argv[1]) == "-r")
        std::cout << scan_number(argv[2], 35) << std::endl;
    else {
        std::cerr << "Usage: ch-2 [-r] number" << std::endl;
        return EXIT_FAILURE;
    }
}
