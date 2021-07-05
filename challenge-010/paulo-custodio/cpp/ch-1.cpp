/*
Challenge 010

Challenge #1
Write a script to encode/decode Roman numerals. For example, given Roman
numeral CCXLVI, it should return 246. Similarly, for decimal number 39, it
should return XXXIX. Checkout wikipedia page for more information.
*/

#include <cassert>
#include <iostream>
#include <string>
#include <cctype>
using namespace std;

int decode_roman(const string& str) {
    int num = 0;
    for (const char* p = str.c_str(); *p; p++) {
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
            cerr << "invalid roman numeral " << *p << endl;
            exit(EXIT_FAILURE);
        }
    }
    return num;
}

string encode_roman(int num) {
    string str;
    while (num >= 1000) { str += "M"; num -= 1000; }
    if (num >= 900) { str += "CM"; num -= 900; }
    if (num >= 500) { str += "D"; num -= 500; }
    if (num >= 400) { str += "CD"; num -= 400; }
    while (num >= 100) { str += "C"; num -= 100; }
    if (num >= 90) { str += "XC"; num -= 90; }
    if (num >= 50) { str += "L"; num -= 50; }
    if (num >= 40) { str += "XL"; num -= 40; }
    while (num >= 10) { str += "X"; num -= 10; }
    if (num >= 9) { str += "IX"; num -= 9; }
    if (num >= 5) { str += "V"; num -= 5; }
    if (num >= 4) { str += "IV"; num -= 4; }
    while (num >= 1) { str += "I"; num--; }
    return str;
}

int main(int argc, char* argv[]) {
    if (argc != 2) return EXIT_FAILURE;
    if (string(argv[1]) == "-test") {
        for (int i = 1; i <= 3000; i++) {
            int num = decode_roman(encode_roman(i));
            assert(num == i);
        }
    }
    else if(isdigit(argv[1][0])) {
        int num = atoi(argv[1]);
        string str = encode_roman(num);
        cout << num << " => " << str << endl;
    }
    else {
        int num = decode_roman(argv[1]);
        cout << argv[1] << " => " << num << endl;
    }
}
