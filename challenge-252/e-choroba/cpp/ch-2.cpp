#include <cassert>
#include <iostream>
#include <vector>

std::vector<int> unique_sum_zero(int n) {
    std::vector<int> v;
    if (n % 2) {
        v = {0};
    }
    for (int i = 1; i <= n / 2; ++i) {
        v.insert(v.end(), {i, -i});
    }
    return v;
}

int main(int argc, char* argv[]) {

    auto u1 = unique_sum_zero(1);
    assert(u1.size() == 1);
    assert(u1[0] == 0);

    auto u2 = unique_sum_zero(2);
    assert(u2.size() == 2);
    assert(u2[0] == 1);
    assert(u2[1] == -1);

    auto u3 = unique_sum_zero(3);
    assert(u3.size() == 3);
    assert(u3[0] == 0);
    assert(u3[1] == 1);
    assert(u3[2] == -1);

    auto u4 = unique_sum_zero(4);
    assert(u4.size() == 4);
    assert(u4[0] == 1);
    assert(u4[1] == -1);
    assert(u4[2] == 2);
    assert(u4[3] == -2);

    std::cout << "Ok." << std::endl;
}
