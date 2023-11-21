/*
Challenge 244

Task 2: Group Hero
Submitted by: Mohammad S Anwar

You are given an array of integers representing the strength.

Write a script to return the sum of the powers of all possible combinations;
power is defined as the square of the largest number in a sequence, multiplied
by the smallest.

Example 1

Input: @nums = (2, 1, 4)
Output: 141

Group 1: (2) => square(max(2)) * min(2) => 4 * 2 => 8
Group 2: (1) => square(max(1)) * min(1) => 1 * 1 => 1
Group 3: (4) => square(max(4)) * min(4) => 16 * 4 => 64
Group 4: (2,1) => square(max(2,1)) * min(2,1) => 4 * 1 => 4
Group 5: (2,4) => square(max(2,4)) * min(2,4) => 16 * 2 => 32
Group 6: (1,4) => square(max(1,4)) * min(1,4) => 16 * 1 => 16
Group 7: (2,1,4) => square(max(2,1,4)) * min(2,1,4) => 16 * 1 => 16

Sum: 8 + 1 + 64 + 4 + 32 + 16 + 16 => 141
*/

#include <algorithm>
#include <cassert>
#include <iostream>
#include <vector>
using namespace std;

class Counter {
public:
    Counter(int k, int max);

    const vector<int>& counters() const { return m_counters; }

    bool increment();       // return false when wrapping arround
    bool is_unique();       // return true if counters are all different and increasing
    bool at_end() const { return m_at_end; }

private:
    int m_max;
    vector<int> m_counters;
    bool m_at_end;
};

Counter::Counter(int k, int max) {
    m_max = max;
    m_counters.resize(k);
    m_at_end = false;
}

bool Counter::increment() {
    if (m_at_end)
        return false;

    int i = static_cast<int>(m_counters.size()) - 1;
    while (i >= 0) {
        m_counters[i]++;
        if (m_counters[i] < m_max)
            return true;
        else {
            m_counters[i] = 0;
            i--;
        }
    }

    m_at_end = true;
    return false;
}

bool Counter::is_unique() {
    for (size_t i = 1; i < m_counters.size(); i++) {
        if (m_counters[i] <= m_counters[i - 1])
            return false;
    }
    return true;
}

class Combination : private Counter {
public:
    Combination(int k, const vector<int>& nums)
        : Counter(k, static_cast<int>(nums.size())), m_k(k), m_nums(nums) {}

    bool next(vector<int>& combo);

private:
    int m_k;
    const vector<int>& m_nums;
};

bool Combination::next(vector<int>& combo) {
    combo.clear();
    if (at_end())
        return false;

    while (!is_unique()) {
        if (!increment())
            return false;
    }

    for (int i = 0; i < m_k; i++)
        combo.push_back(m_nums[counters()[i]]);

    increment();

    return true;
}

int calc_power(const vector<int>& nums) {
    assert(nums.size() > 0);
    int mn = *min_element(nums.begin(), nums.end());
    int mx = *max_element(nums.begin(), nums.end());
    return mx * mx * mn;
}

int compute_power_k(int k, const vector<int>& nums) {
    Combination combination(k, nums);
    vector<int> combo;
    int sum = 0;
    while (combination.next(combo))
        sum += calc_power(combo);
    return sum;
}

int compute_power(const vector<int>& nums) {
    int sum = 0;
    for (int k = 1; k <= static_cast<int>(nums.size()); k++)
        sum += compute_power_k(k, nums);
    return sum;
}

int main(int argc, char* argv[]) {
    if (argc < 2) {
        cerr << "Usage: ch-2 n n n ..." << endl;
        exit(EXIT_FAILURE);
    }

    vector<int> nums;
    for (int i = 1; i < argc; i++)
        nums.push_back(atoi(argv[i]));

    int sum = compute_power(nums);

    cout << sum << endl;
}
