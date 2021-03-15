/*
Challenge 097

TASK #1

*/

#include <iostream>
#include <string>
#include <cctype>

// replace in-place by ciphered text
void caeser(int n, std::string& str) {
    for (auto& c : str) {
        if (isalpha(c))
            c = ((toupper(c)-'A'+26-n)%26)+'A';
    }
}

int main(int argc, char* argv[]) {
    std::string str;
    if (argc > 2) {
        int n = atoi(argv[1]);
        for (int i = 2; i < argc; i++) {
            str += argv[i];
            str += " ";
        }
        str.pop_back();
        caeser(n, str);
        std::cout << str << std::endl;
    }
}
