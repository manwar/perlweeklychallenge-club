/*
Challenge 001

Challenge #1
Write a script to replace the character ‘e’ with ‘E’ in the string
‘Perl Weekly Challenge’. Also print the number of times the character ‘e’
is found in the string.
*/

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
