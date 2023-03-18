/*
Challenge 208

Task 1: Minimum Index Sum
Submitted by: Mohammad S Anwar

You are given two arrays of strings.

Write a script to find out all common strings in the given two arrays with
minimum index sum. If no common strings found returns an empty list.
Example 1

Input: @list1 = ("Perl", "Raku", "Love")
       @list2 = ("Raku", "Perl", "Hate")

Output: ("Perl", "Raku")

There are two common strings "Perl" and "Raku".
Index sum of "Perl": 0 + 1 = 1
Index sum of "Raku": 1 + 0 = 1

Example 2

Input: @list1 = ("A", "B", "C")
       @list2 = ("D", "E", "F")

Output: ()

No common string found, so no result.

Example 3

Input: @list1 = ("A", "B", "C")
       @list2 = ("C", "A", "B")

Output: ("A")

There are three common strings "A", "B" and "C".
Index sum of "A": 0 + 1 = 1
Index sum of "B": 1 + 2 = 3
Index sum of "C": 2 + 0 = 2
*/

#include <iostream>
#include <vector>
#include <string>

std::vector<std::string> common_strings(
    const std::vector<std::string>& list1,
    const std::vector<std::string>& list2
) {
    std::vector<std::string> common;
    int min_index = list1.size() + list2.size() + 1;
    for (size_t i = 0; i < list1.size(); i++) {
        for (size_t j = 0; j < list2.size(); j++) {
            if (list1[i] == list2[j]) {
                if (i+j < min_index) {
                    common.clear();
                    common.push_back(list1[i]);
                    min_index = i+j;
                }
                else if (i+j == min_index) {
                    common.push_back(list1[i]);
                    min_index = i+j;
                }
            }
        }
    }
    return common;
}

int main(int argc, char* argv[]) {
    argv++; argc--;
    if (argc % 2 != 0 || argc == 0) {
        std::cerr << "usage: ch-2 list1 ... list2 ..." << std::endl;
        return EXIT_FAILURE;
    }

    std::vector<std::string> list1;
    std::vector<std::string> list2;
    for (int i = 0; i < argc/2; i++) {
        list1.push_back(argv[i]);
        list2.push_back(argv[i+argc/2]);
    }

    std::vector<std::string> common = common_strings(list1, list2);

    if (common.size() == 0)
        std::cout << "()" << std::endl;
    else {
        for (size_t i = 0; i < common.size(); i++)
            std::cout << common[i] << " ";
        std::cout << std::endl;
    }
}
