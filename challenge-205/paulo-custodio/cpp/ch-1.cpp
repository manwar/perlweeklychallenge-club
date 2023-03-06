/*
Challenge 205

Task 1: Third Highest
Submitted by: Mohammad S Anwar

You are given an array of integers.

Write a script to find out the Third Highest if found otherwise return the maximum.
Example 1

Input: @array = (5,3,4)
Output: 3

First highest is 5. Second highest is 4. Third highest is 3.

Example 2

Input: @array = (5,6)
Output: 6

First highest is 6. Second highest is 5. Third highest is missing, so maximum is returned.

Example 3

Input: @array = (5,4,4,3)
Output: 3

First highest is 5. Second highest is 4. Third highest is 3.
*/

#include <algorithm>
#include <iostream>
#include <vector>

int main(int argc, char* argv[]) {
    argv++; argc--;
    int result = 0;

    if (argc > 0) {
        std::vector<int> items;

        // parse input numbers
        for (int i = 0; i < argc; i++)
            items.push_back(atoi(argv[i]));

        // sort descending
        std::sort(items.rbegin(), items.rend());

        // remove duplicates
        int last = items[0]+1;  // different from first
        size_t j = 0;
        for (size_t i = 0; i < items.size(); i++) {
            if (items[i] != last)
                items[j++] = last = items[i];
        }
        items.resize(j);

        // output
        result = (items.size() < 3) ? items[0] : items[2];
    }

    std::cout << result << std::endl;
    return EXIT_SUCCESS;
}
