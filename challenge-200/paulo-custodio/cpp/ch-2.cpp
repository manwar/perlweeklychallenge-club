/*
Challenge 200

Task 2: Seven Segment 200
Submitted by: Ryan J Thompson
A seven segment display is an electronic component, usually used to display
digits. The segments are labeled 'a' through 'g' as shown:


Seven Segment


The encoding of each digit can thus be represented compactly as a truth table:

my @truth = qw<abcdef bc abdeg abcdg bcfg acdfg acdefg abc abcdefg abcfg>;
For example, $truth[1] = ‘bc’. The digit 1 would have segments ‘b’ and ‘c’ enabled.

Write a program that accepts any decimal number and draws that number as a
horizontal sequence of ASCII seven segment displays, similar to the following:


-------  -------  -------
      |  |     |  |     |
      |  |     |  |     |
-------
|        |     |  |     |
|        |     |  |     |
-------  -------  -------
To qualify as a seven segment display, each segment must be drawn (or not drawn)
according to your @truth table.

The number "200" was of course chosen to celebrate our 200th week!
*/

#include <iostream>
#include <string>

#define A 1
#define B 2
#define C 4
#define D 8
#define E 16
#define F 32
#define G 64

int truth[10] = {
    A|B|C|D|E|F, B|C, A|B|D|E|G, A|B|C|D|G, B|C|F|G,
    A|C|D|F|G, A|C|D|E|F|G, A|B|C, A|B|C|D|E|F|G, A|B|C|F|G
};

void draw_number(int n) {
    std::string s = std::to_string(n);

    // draw a
    for (size_t i = 0; i < s.size(); i++) {
        int digit = s[i] - '0';
        if ((truth[digit] & A)==A)
            std::cout << " ####   ";
        else
            std::cout << "        ";
    }
    std::cout << std::endl;
    // draw f, b
    for (int j = 0; j < 2; j++) {
        for (size_t i = 0; i < s.size(); i++) {
            int digit = s[i] - '0';
            if ((truth[digit] & F)==F) std::cout << "#"; else std::cout << " ";
            std::cout << "    ";
            if ((truth[digit] & B)==B) std::cout << "#"; else std::cout << " ";
            std::cout << "  ";
        }
        std::cout << std::endl;
    }
    // draw g
    for (size_t i = 0; i < s.size(); i++) {
        int digit = s[i] - '0';
        if ((truth[digit] & G)==G)
            std::cout << " ####   ";
        else
            std::cout << "        ";
    }
    std::cout << std::endl;
    // draw e, c
    for (int j = 0; j < 2; j++) {
        for (size_t i = 0; i < s.size(); i++) {
            int digit = s[i] - '0';
            if ((truth[digit] & E)==E) std::cout << "#"; else std::cout << " ";
            std::cout << "    ";
            if ((truth[digit] & C)==C) std::cout << "#"; else std::cout << " ";
            std::cout << "  ";
        }
        std::cout << std::endl;
    }
    // draw d
    for (size_t i = 0; i < s.size(); i++) {
        int digit = s[i] - '0';
        if ((truth[digit] & D)==D)
            std::cout << " ####   ";
        else
            std::cout << "        ";
    }
    std::cout << std::endl;
}

int main(int argc, char* argv[]) {
    argv++; argc--;
    if (argc == 0) {
        std::cerr << "usage: ch-2 num" << std::endl;
        exit(EXIT_FAILURE);
    }

    draw_number(atoi(argv[0]));
}
