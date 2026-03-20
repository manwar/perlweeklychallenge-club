// Perl Weekly Challenge 240 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-240/

#include <algorithm>
#include <cctype>
#include <iostream>
#include <string>
#include <vector>
using namespace std;

void usage(void) {
    cerr << "Usage: ch-1 -str s1 s2 s3 ... -chk check" << endl;
    exit(EXIT_FAILURE);
}

int main(int argc, char* argv[]) {
    vector<string> strs;
    string check, inits;

    // parse args
    int i = 1;
    while (i < argc) {
        string arg = argv[i];
        if (arg=="-str") {
            i++;
            while (i < argc && argv[i][0] != '-') {
                strs.emplace_back(argv[i]);
                i++;
            }
        }
        else if (arg=="-chk") {
            i++;
            if (i < argc) {
                check = argv[i];
                i++;
            }
        }
        else {
            usage();
        }
    }
    if (strs.empty() || check.empty())
        usage();

    // process
    transform(check.begin(), check.end(), check.begin(), ::tolower);

    for (size_t i = 0; i < strs.size(); i++) {
        inits.push_back(tolower(strs[i].front()));
    }

    if (inits==check) {
        cout << "true" << endl;
    }
    else {
        cout << "false" << endl;
    }
}
