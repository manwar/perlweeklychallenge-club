/*
Challenge 096

TASK #2 › Edit Distance
Submitted by: Mohammad S Anwar
You are given two strings $S1 and $S2.

Write a script to find out the minimum operations required to convert $S1
into $S2. The operations can be insert, remove or replace a character. Please
check out Wikipedia page for more information.

Example 1:
Input: $S1 = "kitten"; $S2 = "sitting"
Output: 3

Operation 1: replace 'k' with 's'
Operation 2: replace 'e' with 'i'
Operation 3: insert 'g' at the end
Example 2:
Input: $S1 = "sunday"; $S2 = "monday"
Output: 2

Operation 1: replace 's' with 'm'
Operation 2: replace 'u' with 'o'
*/

#include <algorithm>
#include <iostream>
#include <string>
#include <vector>
#include <cassert>
#include <climits>

int min3(int a, int b, int c) {
    return std::min(a, std::min(b, c));
}

int wag_fis_dist(const std::string& a, const std::string& b) {
    size_t len_a = a.size();
    size_t len_b = b.size();

    // define a table where d[i][j] is the Levenshtein distance between
    // first i chars of a and first j chars of b
    std::vector<std::vector<int>> d;
    d.resize(len_a+1);
    for (size_t i = 0; i <= len_a; i++) {
        d[i].resize(len_b+1);
    }

    // source prefixes can be transformed into empty string by dropping chars
    for (size_t i = 1; i <= len_a; i++)
        d[i][0] = i;

    // target prefixes can be reached from empty source prefix by inserting chars
    for (size_t j = 1; j <= len_b; j++)
        d[0][j] = j;

    // flood-fill the rest of the table
    for (size_t j = 1; j <= len_b; j++) {
        for (size_t i = 1; i <= len_a; i++) {
            int subst_cost = (a[i-1] == b[j-1]) ? 0 : 1;
            d[i][j] = min3(d[i-1][j]+1,             // deletion
                           d[i][j-1]+1,             // insertion
                           d[i-1][j-1]+subst_cost); // substitution
        }
    }

    // distance is in lower bottom cell
    return d[len_a][len_b];
}

int main(int argc, char* argv[]) {
    if (argc != 3) {
        std::cerr << "Usage: ch-2 s1 s2" << std::endl;
        return EXIT_FAILURE;
    }

    std::cout << wag_fis_dist(argv[1], argv[2]) << std::endl;
}
