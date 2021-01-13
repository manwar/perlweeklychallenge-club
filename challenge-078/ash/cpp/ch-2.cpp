/*
    Task 2 from
    https://perlweeklychallenge.org/blog/perl-weekly-challenge-078/

    Comments: https://andrewshitov.com/2020/09/14/the-weekly-challenge-078/

    Compile:
    $ g++ -std=c++17 ch-2.cpp

    Output:

    $ ./a.out 
    40 50 10 20 30 
    50 10 20 30 40 
*/

#include <iostream>
#include <vector>

using namespace std;

int main() {
    vector<int> a = {10, 20, 30, 40, 50};
    vector<int> b = {3, 4};

    for (auto shift : b) {
        for (auto pos = 0; pos != a.size(); pos++) {
            cout << a[(pos + shift) % a.size()] << ' ';
        }
        cout << endl;
    }
}
