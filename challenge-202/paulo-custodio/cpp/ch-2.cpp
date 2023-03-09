/*
Challenge 202

Task 2: Widest Valley
Submitted by: E. Choroba

Given a profile as a list of altitudes, return the leftmost widest valley.
A valley is defined as a subarray of the profile consisting of two parts:
the first part is non-increasing and the second part is non-decreasing.
Either part can be empty.

Example 1

Input: 1, 5, 5, 2, 8
Output: 5, 5, 2, 8

Example 2

Input: 2, 6, 8, 5
Output: 2, 6, 8

Example 3

Input: 9, 8, 13, 13, 2, 2, 15, 17
Output: 13, 13, 2, 2, 15, 17

Example 4

Input: 2, 1, 2, 1, 3
Output: 2, 1, 2

Example 5

Input: 1, 3, 3, 2, 1, 2, 3, 3, 2
Output: 3, 3, 2, 1, 2, 3, 3
*/

#include <iostream>
#include <vector>

void largest_valey(const std::vector<int>& heights, std::vector<int>& valey) {
    int l1 = 0, r1 = -1;        // initial interval

    // find largest valey
    int heights_size = static_cast<int>(heights.size());
    for (int c = 0; c < heights_size; c++) {    // center of valey

        int l = c;                              // left
        while (l-1 >= 0 && heights[l-1] >= heights[l])
            l--;

        int r = c;                              // right
        while (r+1 < heights_size && heights[r+1] >= heights[r])
            r++;

        if (r - l + 1 > r1 - l1 + 1) {
            l1 = l;
            r1 = r;
        }
    }

    // return valey in heights array
    valey.resize(r1-l1+1);
    memmove(&valey[0], &heights[l1], (r1-l1+1)*sizeof(int));
}

int main(int argc, char* argv[]) {
    argv++; argc--;
    if (argc < 2) {
        fputs("Usage: ch-2 height...\n", stderr);
        return EXIT_FAILURE;
    }

    std::vector<int> heights;
    for (int i = 0; i < argc; i++)
        heights.push_back(atoi(argv[i]));

    std::vector<int> valey;
    largest_valey(heights, valey);
    for (size_t i = 0; i < valey.size(); i++)
        std::cout << valey[i] << " ";
    std::cout << std::endl;

    return EXIT_SUCCESS;
}
