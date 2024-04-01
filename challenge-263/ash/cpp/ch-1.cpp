// Solution of Task 1 of The Weekly Challenge 263
// https://theweeklychallenge.org/blog/perl-weekly-challenge-263/

/*
    $ c++ -std=c++20 ch-1.cpp

    $ ./a.out 
    (1, 2)
    ()
    (4)
*/

#include<iostream>
#include<vector>
#include<algorithm>
#include<string>

using namespace std;

int main() {
    vector<vector<int>> tests = {
        {1, 5, 3, 2, 4, 2},
        {1, 2, 4, 3, 5},
        {5, 3, 2, 4, 2, 1}
    };

    int values[] = {2, 6, 4};

    for (int n = 0; n != tests.size(); n++) {
        auto vec = tests[n];
        auto value = values[n];

        sort(vec.begin(), vec.end());

        vector<int> result;
        for (int c = 0; c != vec.size(); c++) {
            if (vec[c] == value) result.push_back(c);
            if (vec[c] > value) break;
        }

        cout << "(";
        for (int c = 0; c != result.size(); c++) {
            cout << result[c];
            if (c < result.size() - 1) cout << ", ";
        }
        cout << ")" << endl;
    }
}
