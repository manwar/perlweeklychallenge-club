// Perl Weekly Challenge 240 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-240/

#include <iostream>
#include <vector>
using namespace std;

int main(int argc, char* argv[]) {
    if (argc < 2) {
        cerr << "Usage: ch-2 n n n ..." << endl;
        exit(EXIT_FAILURE);
    }

    vector<int> olds;
    vector<int> news;

    // parse args
    for (int i = 1; i < argc; i++) {
        int n = atoi(argv[i]);
        olds.push_back(n);
    }

    // process
    for (size_t i = 0; i < olds.size(); i++) {
        int n = olds[olds[i]];
        news.push_back(n);
    }

    // output
    const char* sep = "";
    for (size_t i = 0; i < news.size(); i++) {
        cout << sep << news[i];
        sep = " ";
    }
    cout << endl;
}
