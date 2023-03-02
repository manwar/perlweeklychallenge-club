/*
Challenge 204

Task 2: Reshape Matrix
Submitted by: Mohammad S Anwar

You are given a matrix (m x n) and two integers (r) and (c).

Write a script to reshape the given matrix in form (r x c) with the original value in the given matrix. If you can’t reshape print 0.

Example 1

Input: [ 1 2 ]
       [ 3 4 ]

       $matrix = [ [ 1, 2 ], [ 3, 4 ] ]
       $r = 1
       $c = 4

Output: [ 1 2 3 4 ]

Example 2

Input: [ 1 2 3 ]
       [ 4 5 6 ]

       $matrix = [ [ 1, 2, 3 ] , [ 4, 5, 6 ] ]
       $r = 3
       $c = 2

Output: [ [ 1, 2 ], [ 3, 4 ], [ 5, 6 ] ]

        [ 1 2 ]
        [ 3 4 ]
        [ 5 6 ]

Example 3

Input: [ 1 2 ]

       $matrix = [ [ 1, 2 ] ]
       $r = 3
       $c = 2

Output: 0
*/

#include <iostream>
#include <sstream>
#include <vector>
#include <string>

std::vector<int> data;
size_t rows = 0, cols = 0;

void parse_data() {
    std::string line;
    while (std::getline(std::cin, line)) {
        if (line.find('[') != std::string::npos) {
            size_t pos;
            while ((pos = line.find('[')) != std::string::npos) line[pos] = ' ';
            while ((pos = line.find(']')) != std::string::npos) line[pos] = ' ';
            std::istringstream iss{ line };
            int n;
            while (iss >> n) {
                data.push_back(n);
            }
        }
        else {
            std::istringstream iss{ line };
            iss >> rows >> cols;
            break;
        }
    }
}

void output_data() {
    if (data.size() != rows*cols)
        std::cout << "0" << std::endl;
    else {
        for (int i = 0; i < rows; i++) {
            std::cout << "[ ";
            for (int j = 0; j < cols; j++) {
                std::cout << data[i*cols+j] << " ";
            }
            std::cout << "]" << std::endl;
        }
    }
}

int main() {
    parse_data();
    output_data();
}
