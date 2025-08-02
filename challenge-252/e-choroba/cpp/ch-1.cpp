#include <cassert>
#include <cmath>
#include <iostream>
#include <vector>

long special_numbers(std::vector<long> ints) {
    size_t s = ints.size();
    long r = 0;
    for (size_t i = 0; i <= s; ++i) {
        if (s % (i + 1) == 0) {
            r += std::pow(ints[i], 2);
        }
    }
    return r;
}

int main(int argc, char* argv[]) {
    assert(special_numbers({1, 2, 3, 4}) == 21);
    assert(special_numbers({2, 7, 1, 19, 18, 3}) == 63);
    std::cout << "Ok." << std::endl;
}
