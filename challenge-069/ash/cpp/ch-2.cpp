// Compile as: g++ -std=c++17 ch-2.cpp

#include <iostream>
#include <vector>

using namespace std;

int main() {
    vector<bool> bits;
    bits.push_back(0);

    for (int n = 2; n <= 8; n++) {
        int size = bits.size();
        bits.push_back(0);

        cout << 'S' << n << " = ";

        for (int m = 1; m <= size; m++)
            bits.push_back(!bits[size - m]);

        for (auto x : bits) cout << x;
        cout << endl;
    }
}
