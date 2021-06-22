/*
Challenge 007

Challenge #2

Word Ladder
A word ladder is a sequence of words [w0, w1, …, wn] such that each word wi
in the sequence is obtained by changing a single character in the word wi-1.
All words in the ladder must be valid English words.

Given two input words and a file that contains an ordered word list,
implement a routine (e.g., find_shortest_ladder(word1, word2, wordlist))
that finds the shortest ladder between the two input words. For example,
for the words cold and warm, the routine might return:

("cold", "cord", "core", "care", "card", "ward", "warm")

However, there’s a shortest ladder:
(“cold”, “cord”, “card”, “ward”, “warm”).

Givens:
All words in the list have the same length.

All words contain only lowercase alphabetical characters.

There are no duplicates in the word list.

The input words aren’t empty and aren’t equal but they have the same length
as any word in the word list.

Requirements:
The routine must return a list of the words in the ladder if it exists.
Otherwise, it returns an empty list.

If any of the input words is the wrong length (i.e., its length is different
to a random from the word list) or isn’t in the word list, return an empty
list.
*/

#include <algorithm>
#include <cctype>
#include <climits>
#include <deque>
#include <fstream>
#include <iostream>
#include <set>
#include <string>
#include <vector>
using namespace std;

class Path {
public:
    void push_back(const string& word) {
        if (word_set.find(word) != word_set.end()) {
            cerr << "Word " << word << " already in list" << endl;
            exit(EXIT_FAILURE);
        }
        word_list.push_back(word);
        word_set.insert(word);
    }

    bool contains(const string& word) const {
        return word_set.find(word) != word_set.end();
    }

    string front() const { return word_list.front(); }
    string back() const { return word_list.back(); }

    vector<string>::iterator begin() { return word_list.begin(); }
    vector<string>::iterator end() { return word_list.end(); }

    vector<string>::const_iterator cbegin() const { return word_list.cbegin(); }
    vector<string>::const_iterator cend() const { return word_list.cend(); }

    void clear() {
        word_list.clear();
        word_set.clear();
    }

    void sort() {
        ::sort(word_list.begin(), word_list.end());
    }

    friend ostream& operator<<(ostream& os, const Path& path) {
        os << "(";
        string separator = "";
        for (auto& word : path.word_list) {
            os << separator << '"' << word << '"';
            separator = ", ";
        }
        os << ")";
        return os;
    }

private:
    vector<string>  word_list;
    set<string>     word_set;
};

Path all_words;

bool word_is_lower(const string& word) {
    for (size_t i = 0; i < word.size(); i++)
        if (word[i] < 'a' || word[i] > 'z')
            return false;
    return true;
}

int word_diff(const string& word1, const string& word2) {
    int diff = 0;
    for (size_t i = 0; i < word1.size(); i++)
        if (word1[i] != word2[i])
            diff++;
    return diff;
}

vector<string> next_words(const Path& path) {
    vector<string> ret;
    string last_word = path.back();
    for (auto& word : all_words) {
        if (word_diff(last_word, word) == 1)
            if (!path.contains(word))
                ret.push_back(word);
    }
    return ret;
}

// read all words with the given length
void read_words(int len) {
    all_words.clear();
    ifstream ifs("words.txt");
    if (!ifs.is_open()) {
        cerr << "cannot open words.txt" << endl;
        exit(EXIT_FAILURE);
    }
    string word;
    while (getline(ifs, word)) {
        if (word.size() == len && word_is_lower(word))
            all_words.push_back(word);
    }

    all_words.sort();
}

// find shortest ladder
Path find_shortest_ladder(const string& word1, const string& word2) {
    // build initial path
    Path path;
    path.push_back(word1);

    // build initial queue
    deque<Path> queue;
    queue.push_back(path);

    while (!queue.empty()) {
        // current path being examined
        path = queue.front();
        queue.pop_front();

        // check if finished
        if (path.back() == word2)
            return path;

        // find next step
        auto words = next_words(path);
        for (auto& word : words) {
            Path new_path = path;
            new_path.push_back(word);
            queue.push_back(new_path);
        }
    }

    // not found
    path.clear();
    return path;
}

int main(int argc, char* argv[]) {
    if (argc != 3) {
        cerr << "Usage: ch-2 word1 word2" << endl;
        return EXIT_FAILURE;
    }

    string word1 = argv[1];
    string word2 = argv[2];

    if (word1.size() != word2.size()) {
        cerr << "words must have the same length" << endl;
        return EXIT_FAILURE;
    }

    if (word1 == word2) {
        cerr << "words must be different" << endl;
        return EXIT_FAILURE;
    }

    if (!word_is_lower(word1) || !word_is_lower(word2)) {
        cerr << "words must have lower case letters only" << endl;
        return EXIT_FAILURE;
    }

    // reads to all_words with same size
    read_words(word1.size());

    if (!all_words.contains(word1) ||!all_words.contains(word2)) {
        cerr << "words not found in dictionary" << endl;
        return EXIT_FAILURE;
    }

    // find sortest ladder
    Path path = find_shortest_ladder(word1, word2);
    cout << path << endl;

    return EXIT_SUCCESS;
}
