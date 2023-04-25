#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

int main() {
    int N = 4;
    std::vector<std::string> grayCode = {"0", "1"};

    for (int i = 2; i <= N; i++) {
        std::vector<std::string> revGrayCode(grayCode.rbegin(), grayCode.rend());
        for (auto &x : grayCode) x = '0' + x;
        for (auto &x : revGrayCode) x = '1' + x;
        grayCode.insert(grayCode.end(), revGrayCode.begin(), revGrayCode.end());
    }

    for (const auto &x : grayCode) {
        std::cout << std::stoi(x, nullptr, 2) << ' ';
    }
    std::cout << '\n';

    return 0;
}
