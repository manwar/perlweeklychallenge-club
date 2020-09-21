/*
    Task 1 from
    https://perlweeklychallenge.org/blog/perl-weekly-challenge-078/

    Comments: https://andrewshitov.com/2020/09/14/the-weekly-challenge-078/

    Compile as:
    $ g++ -std=c++17 ch-1.cpp 
*/

#include <iostream>
#include <vector>

using namespace std;

int main() {
    vector<int> a = {9, 10, 7, 5, 6, 1};

    auto max = a.back();
    vector<int> leaders = {max};
    for (auto i = a.rbegin(); i != a.rend(); i++) {
        if (*i > max) {
            max = *i;
            leaders.push_back(max);
        }
    }

    for (auto i = leaders.rbegin(); i != leaders.rend(); i++)
        cout << *i << endl;
}
