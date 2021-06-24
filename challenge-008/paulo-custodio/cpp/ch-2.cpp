/*
Challenge 008

Challenge #2
Write a function, ‘center’, whose argument is a list of strings, which will
be lines of text. The function should insert spaces at the beginning of the
lines of text so that if they were printed, the text would be centered, and
return the modified lines.
*/

#include <iostream>
#include <vector>
#include <string>
using namespace std;

void center(vector<string>& lines) {
    size_t max_len = 0;

    for (auto& line : lines)
        if (line.size() > max_len)
            max_len = line.size();

    for (auto& line : lines)
        line = string((max_len - static_cast<int>(line.size())) / 2, ' ') + line;
}

int main(int argc, char* argv[]) {
    argc--; argv++;

    vector<string> lines;
    for (int i = 0; i < argc; i++)
        lines.push_back(argv[i]);

    center(lines);

    for (auto& line : lines)
        cout << line << endl;
}
