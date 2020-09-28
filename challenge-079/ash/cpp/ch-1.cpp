/*
    Task 1 from
    https://perlweeklychallenge.org/blog/perl-weekly-challenge-079/
*/

#include <iostream>
#include <sstream>

using namespace std;

int main(int argc, char** argv) {
    if (argc != 2) {
        cerr << "Usage: ./a.out 42" << endl;
        return 1;
    }

    stringstream input(argv[1]);
  
    int n;
    input >> n;

    int total_bits = 0;
    int scale = 1;
    n++;
    while (scale <= n) {
        int scale2 = scale << 1;
        
        int fill_full = n / scale2;
        int fill_frac = n % scale2;

        int bits_full = fill_full * scale;
        int bits_frac = 0;
        if (fill_frac > scale) {
            bits_frac = fill_frac - scale;
        }

        total_bits += bits_full + bits_frac;

        scale = scale2;
    }

    cout << "There are " << total_bits << " set bits in the sequence from 1 to " << n << endl;
}
