/*
Challenge 245

Task 1: Sort Language
Submitted by: Mohammad S Anwar

You are given two array of languages and its popularity.

Write a script to sort the language based on popularity.
Example 1

Input: @lang = ('perl', 'c', 'python')
       @popularity = (2, 1, 3)
Output: ('c', 'perl', 'python')

Example 2

Input: @lang = ('c++', 'haskell', 'java')
       @popularity = (1, 3, 2)
Output: ('c++', 'java', 'haskell')
*/

#include <algorithm>
#include <iostream>
#include <string>
#include <vector>
using namespace std;

struct Elem {
    string name;
    int pop;

    Elem(const string& name_ = "", int pop_ = 0) :name(name_), pop(pop_) {}
    bool operator<(const Elem& other) { return pop < other.pop ? true : false; }
};

int main(int argc, char* argv[]) {
    if (argc < 2) {
        cerr << "Usage: ch-1 lang pop lang pop ..." << endl;
        exit(EXIT_FAILURE);
    }

    vector<Elem> langs;
    for (int i = 1; i + 1 < argc; i += 2) {
        langs.emplace_back(argv[i], atoi(argv[i + 1]));
    }

    sort(langs.begin(), langs.end());

    for (auto& lang : langs)
        cout << lang.name << " ";
    cout << endl;
}
