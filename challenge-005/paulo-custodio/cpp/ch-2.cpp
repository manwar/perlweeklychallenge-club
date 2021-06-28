/*
Challenge 005

Challenge #2
Write a program to find the sequence of characters that has the most anagrams.

create a hash of all words in dictionary where key is sorted list of letters
therefore two anagrams have the same key
*/

#include <algorithm>
#include <cctype>
#include <fstream>
#include <iostream>
#include <map>
#include <string>
using namespace std;

map<string, int> anagrams;

void strtolower(string& str) {
    for (size_t i = 0; i < str.size(); i++)
        str[i] = tolower(str[i]);
}

void word_key(string& key, const string& word) {
    key = word;
    sort(key.begin(), key.end());
}

int main() {
    int max_anagrams = 0;
    string key, line;

    ifstream ifs("words.txt");
    if (!ifs.is_open()) return EXIT_FAILURE;

    // collect anagram keys and count occurrences
    while (getline(ifs, line)) {
        strtolower(line);
        word_key(key, line);

        auto found = anagrams.find(key);
        if (found == anagrams.end()) {
            anagrams[key] = 1;

            if (max_anagrams < 1)
                max_anagrams = 1;
        }
        else {
            found->second++;

            if (max_anagrams < found->second)
                max_anagrams = found->second;
        }
    }

    // list anagrams
    cout << "Maximum of " << max_anagrams << " anagrams" << endl;
    for (auto& it : anagrams) {
        if (it.second == max_anagrams)
            cout << it.first << endl;
    }

    return EXIT_SUCCESS;
}
