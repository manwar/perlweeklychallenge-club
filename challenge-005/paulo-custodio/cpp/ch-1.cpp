/*
Challenge 005

Challenge #1
Write a program which prints out all anagrams for a given word. For more
information about Anagram, please check this wikipedia page.
create a hash of all words in dictionary where key is sorted list of letters
therefore two anagrams have the same key
*/

#include <algorithm>
#include <cctype>
#include <fstream>
#include <iostream>
#include <string>
using namespace std;

void strtolower(string& str) {
    for (size_t i = 0; i < str.size(); i++)
        str[i] = tolower(str[i]);
}

void word_key(string& key, const string& word) {
    key = word;
    sort(key.begin(), key.end());
}

int main(int argc, char* argv[]) {
    string key1, key2, line;

    if (argc != 2) return EXIT_FAILURE;
    word_key(key1, argv[1]);
    strtolower(key1);

    ifstream ifs("words.txt");
    if (!ifs.is_open()) return EXIT_FAILURE;

    while (getline(ifs, line)) {
        strtolower(line);
        word_key(key2, line);
        if (key1 == key2)
            cout << line << endl;
    }

    return EXIT_SUCCESS;
}
