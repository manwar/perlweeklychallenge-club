/*
Challenge 242

Task 1: Missing Members
Submitted by: Mohammad S Anwar
You are given two arrays of integers.

Write a script to find out the missing members in each other arrays.

Example 1
Input: @arr1 = (1, 2, 3)
       @arr2 = (2, 4, 6)
Output: ([1, 3], [4, 6])

(1, 2, 3) has 2 members (1, 3) missing in the array (2, 4, 6).
(2, 4, 6) has 2 members (4, 6) missing in the array (1, 2, 3).
Example 2
Input: @arr1 = (1, 2, 3, 3)
       @arr2 = (1, 1, 2, 2)
Output: ([3])

(1, 2, 3, 3) has 2 members (3, 3) missing in the array (1, 1, 2, 2). Since they are same, keep just one.
(1, 1, 2, 2) has 0 member missing in the array (1, 2, 3, 3).
*/

#include <algorithm>
#include <iostream>
#include <regex>
#include <string>
#include <vector>
using namespace std;

vector<string> regex_split(const string& s, const regex& sep_regex = regex{ "\\s+" }) {
    sregex_token_iterator iter(s.begin(), s.end(), sep_regex, -1);
    sregex_token_iterator end;
    return { iter, end };
}

vector<int> parse_list(const string& text) {
    vector<int> result;
    auto nums = regex_split(text, regex{ "[\\[\\](),; \\t]+" });
    for (auto& num : nums) {
        if (!num.empty()) {
            int n = stoi(num);
            result.push_back(n);
        }
    }
    sort(result.begin(), result.end());
    return result;
}

vector<int> find_not_in(const vector<int>& arr1, const vector<int>& arr2) {
    vector<int> result;
    for (auto& n : arr1) {
        if (!binary_search(arr2.begin(), arr2.end(), n))
            if (!binary_search(result.begin(), result.end(), n))
                result.push_back(n);
    }
    return result;
}

void print_list(const vector<int>& arr) {
    cout << "[";
    string sep = "";
    for (auto& n : arr) {
        cout << sep << n;
        sep = ", ";
    }
    cout << "]";
}

void print_result(const vector<int>& arr1, const vector<int>& arr2) {
    cout << "(";
    string sep = "";
    if (!arr1.empty()) {
        cout << sep;
        print_list(arr1);
        sep = ", ";
    }
    if (!arr2.empty()) {
        cout << sep;
        print_list(arr2);
        sep = ", ";
    }
    cout << ")";
}

int main(int argc, char* argv[]) {
    if (argc != 3) {
        cerr << "Usage: ch-1 '(a,b,c)' '(d,e,f)'" << endl;
        exit(EXIT_FAILURE);
    }

    auto arr1 = parse_list(argv[1]);
    auto arr2 = parse_list(argv[2]);

    auto not_in1 = find_not_in(arr1, arr2);
    auto not_in2 = find_not_in(arr2, arr1);

    print_result(not_in1, not_in2);
}
