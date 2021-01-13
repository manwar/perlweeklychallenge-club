/*
    Task 1 from
    https://perlweeklychallenge.org/blog/perl-weekly-challenge-085/#TASK1

    $ g++ -std=c++17 ch-1.cpp
    $ ./a.out 
    1
*/

#include <iostream>
#include <vector>

using namespace std;

int main() {
    vector<double> r = {1.2, 0.4, 0.1, 2.5};
    // vector<double> r = {0.2, 1.5, 0.9, 1.1};

    bool found = false;
    for (unsigned int c = 0; c != 2 << (r.size() - 1); c++) {
        unsigned int mask = c;
        unsigned int unit_bits = 0;
        double sum = 0;
        for (unsigned int bitpos = r.size(); bitpos; bitpos--) {
            unsigned int current_bit = mask & 1;
            unit_bits += current_bit;
            mask >>= 1;

            if (current_bit) sum += r[bitpos - 1];
        }

        if (unit_bits == 3 && sum > 1 && sum < 2) {
            cout << 1 << endl;
            found = true;
            break;
        }
    }

    if (!found) cout << 0 << endl;
}
