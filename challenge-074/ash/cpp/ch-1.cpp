/*
    Task 1 from
    https://perlweeklychallenge.org/blog/perl-weekly-challenge-074/

    Comments: https://andrewshitov.com/2020/08/18/the-weekly-challenge-for-74/

    Compile as:
    $ g++ --std=c++17 ch-1.cpp
*/

#include <iostream>
#include <vector>
#include <map>
#include <algorithm>

using namespace std;

int main() {
    vector<int> data = {1, 2, 2, 3, 2, 4, 2};
    // vector<int> data = {1, 3, 1, 2, 4, 5};

    map<int, int> frequency;
    int max_frequency = 0;
    int major = 0;
    for (auto x : data) {
        if (++frequency[x] > max_frequency) {
            max_frequency = frequency[x];
            major = x;
        }
    }

    cout << (max_frequency > data.size() / 2 ? major : -1) << endl;
}
