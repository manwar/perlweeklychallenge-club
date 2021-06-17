/*
Challenge 004
Challenge #2
You are given a file containing a list of words (case insensitive 1 word per
line) and a list of letters. Print each word from the file that can be made
using only letters from the list. You can use each letter only once (though
there can be duplicates and you can use each of them once), you don’t have to
use all the letters. (Disclaimer: The challenge was proposed by Scimon Proctor)
*/

#include <iostream>
#include <fstream>
#include <string>
#include <cctype>
using namespace std;

void strtolower(string& str) {
    for (size_t i = 0; i < str.size(); i++)
        str[i] = tolower(str[i]);
}

bool strisalpha(string& str) {
    for (size_t i = 0; i < str.size(); i++)
        if (!isalpha(str[i]))
            return false;
    return true;
}

bool matches(const string& word, const string& letters) {
    string pending = word;
    for (size_t i = 0; i < letters.size(); i++) {
        size_t found = pending.find(letters[i]);
        if (found != string::npos)
            pending.erase(found, 1);
    }
    if (pending.size() == 0)
        return true;
    else
        return false;
}

int main(int argc, char* argv[]) {
    if (argc != 2) return EXIT_FAILURE;

    string letters = argv[1];
    strtolower(letters);

    ifstream ifs("words.txt");
    if (!ifs.is_open()) return EXIT_FAILURE;

    string word;
    while (getline(ifs, word)) {
        if (word.size() >= 2 &&
            strisalpha(word) &&
            matches(word, letters)
            )
            cout << word << endl;
    }

    return EXIT_SUCCESS;
}
