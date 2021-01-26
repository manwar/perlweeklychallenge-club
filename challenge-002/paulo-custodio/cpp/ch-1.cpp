/*
Challenge 002

Challenge #1
Write a script or one-liner to remove leading zeros from positive numbers.
*/

#include <iostream>
#include <cctype>

int main(int argc, char* argv[]) {
    if (argc==2) {
        char* p = argv[1];
        while (*p=='0' && isdigit(p[1]))
            p++;
        std::cout << p << std::endl;
    }
}
