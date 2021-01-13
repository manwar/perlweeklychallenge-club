/*
    Task 2 from https://perlweeklychallenge.org/blog/perl-weekly-challenge-075/
 
    Comments: https://andrewshitov.com/2020/08/29/largest-rectangle-histogram-the-raku-challenge-week-75-task-2/

    How to compile: 
    $ g++ --std=c++17 ch-2.cpp
*/

#include <iostream>
#include <vector>

using namespace std;

int main() {
    vector<int> hist = {3, 2, 3, 5, 7, 5};

    int max_area = 0;
    int max_start;
    int max_end;

    for (auto start = 0; start <= hist.size(); start++) {
        for (auto end = start + 1; end < hist.size(); end++) {
            auto min_height = INT_MAX;
            for (auto i = start; i != end; i++) {
                if (hist[i] < min_height) min_height = hist[i];
            }

            auto area = min_height * (1 + end - start);

            if (area > max_area) {
                max_area = area;
                max_start = start;
                max_end = end;
            }
        }
    }

    cout << "The biggest rectangle is between the columns " << max_start << " and " << max_end 
        << " and its area is " << max_area << ".\n";
}
