// Perl Weekly Challenge 001 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-001/

#include <iostream>
#include <string>

int replace_e(std::string& text) {
    int count = 0;
    for (auto& c : text) {
        if (c == 'e') {
            c = 'E';
            count++;
        }
    }
    return count;
}

int main(int argc, char* argv[]) {
    std::string text;
    for (int i = 1; i < argc; i++) {
        text += argv[i];
        text += " ";
    }
    if (!text.empty())
        text.pop_back();            // remove last space

    std::cout << replace_e(text) << " " << text << std::endl;
}
