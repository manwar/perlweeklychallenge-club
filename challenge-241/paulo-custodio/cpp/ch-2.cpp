/*
Challenge 241

Task 2: Prime Order
Submitted by: Mohammad S Anwar

You are given an array of unique positive integers greater than 2.

Write a script to sort them in ascending order of the count of their prime
factors, tie-breaking by ascending value.
Example 1

Input: @int = (11, 8, 27, 4)
Output: (11, 4, 8, 27))

Prime factors of 11 => 11
Prime factors of  4 => 2, 2
Prime factors of  8 => 2, 2, 2
Prime factors of 27 => 3, 3, 3
*/

#include <algorithm>
#include <iostream>
#include <vector>
using namespace std;

struct Num {
    int n;
    vector<int> factors;

    Num(int n);
    bool operator<(const Num& other);
};

bool is_prime(int n) {
    if (n <= 1)
        return false;
    if (n <= 3)
        return true;
    if ((n % 2) == 0 || (n % 3) == 0)
        return false;
    for (int i = 5; i * i <= n; i += 6)
        if ((n % i) == 0 || (n % (i + 2)) == 0)
            return false;
    return true;
}

int next_prime(int n) {
    if (n <= 1)
        return 2;
    do {
        n++;
    } while (!is_prime(n));
    return n;
}

vector<int> prime_factors(int n) {
    vector<int> out;
    if (n < 2) {
        int p = 1;
        out.push_back(p);
    }
    else {
        int p = 2;
        while (n > 1) {
            while (n % p == 0) {
                out.push_back(p);
                n /= p;
            }
            p = next_prime(p);
        }
    }
    return out;
}

Num::Num(int n) {
    this->n = n;
    this->factors = prime_factors(n);
}

int num_compare(const Num& a, const Num& b) {
    int a_size = static_cast<int>(a.factors.size());
    int b_size = static_cast<int>(b.factors.size());
    if (a_size != b_size)
        return a_size - b_size;
    for (size_t i = 0; i < a_size; i++) {
        if (a.factors[i] != b.factors[i])
            return a.factors[i] - b.factors[i];
    }
    return 0;
}

bool Num::operator<(const Num& other) {
    return num_compare(*this, other) < 0 ? true : false;
}

int main(int argc, char* argv[]) {
    if (argc < 2) {
        cerr << "Usage: ch-2 n n n ..." << endl;
        exit(EXIT_FAILURE);
    }

    vector<Num> nums;

    // parse args and compute primes
    for (int i = 1; i < argc; i++) {
        int n = atoi(argv[i]);
        nums.emplace_back(n);
    }

    // sort
    sort(nums.begin(), nums.end());

    // output
    const char* sep = "";
    for (auto& num : nums) {
        cout << sep << num.n;
        sep = " ";
    }
}
