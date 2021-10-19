

#include<iostream>
#include<vector>
#include<algorithm>
/*
* You are given 2 positive numbers, m and n.
* Write a script to generate multiplcation table and display count of distinct terms.
*/


class DistinctTermsCount {
    public:
        std::vector<int> compute_print(int, int);
};


std::vector<int> DistinctTermsCount::compute_print(int m, int n) {
    std::vector<int> distinct;
    std::cout << " x | ";
    for(int k = 1; k <= n; k++) {
        std::cout << " " << k;
    }
    std::cout << std::endl;
    std::cout << "---+-";
    for(int k = 1; k <= n * 2; k++) {
        std::cout << "-";
    }
    std::cout << std::endl;
    for(int i = 1; i <= m; i++) {
        std::cout << " " << i << " | ";
        for(int j = 1; j <= n; j++) {
            int x = i * j;
            std::cout << " " << x;
            if(std::count(distinct.begin(), distinct.end(), x) == 0) {
                distinct.push_back(x);
            }
        }
        std::cout << std::endl;
    }
    return distinct;
}


int main(int argc, char** argv) {
    DistinctTermsCount dtc;
    std::vector<int> distinct = dtc.compute_print(3, 3);
    std::cout << "Distinct Terms: ";
    for(int i = 0; i < distinct.size() - 1; i++) {
        std::cout << distinct[i] << ", ";
    }
    std::cout << distinct[distinct.size() - 1] << std::endl;
    std::cout << "Count: " << distinct.size() << std::endl;
}

