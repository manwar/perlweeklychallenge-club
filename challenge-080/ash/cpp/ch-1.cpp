/*
    Task 1 from
    https://perlweeklychallenge.org/blog/perl-weekly-challenge-080/
*/

#include <iostream>
#include <vector>
#include <map>

using namespace std;

int missing_n(vector<int> n) {
    map<int, bool> v;

    int max = n[0];
    for (auto x : n) {
        v[x] = true;
        if (x > max) max = x;
    }

    for (auto c = 1; c <= max ; c++) {
        if (!v[c]) {
            return c;
            break;
        }
    }

    return max + 1;
}

int main() {
    cout << (missing_n(vector<int> {5, 2, -2, 0})          == 1) << endl;
    cout << (missing_n(vector<int> {1, 8, -1})             == 2) << endl;
    cout << (missing_n(vector<int> {5, 2, -2, 0})          == 1) << endl;

    cout << (missing_n(vector<int> {5, 2, 3, 1, -2, 0})    == 4) << endl;
    cout << (missing_n(vector<int> {5, 2, 3, 1, 4, -2, 0}) == 6) << endl;
}
