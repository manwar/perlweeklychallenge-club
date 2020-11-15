#include <iostream>
#include <algorithm>
#include <vector>

// g++ --std=c++17 c1.cpp && ./a.out

void pair_diff(unsigned int reference, std::vector<int> nums)
{
    std::sort(nums.begin(), nums.end(), std::greater<int>());
    auto start = nums.begin();
    auto curr = start;
    while(start != nums.end() && curr != nums.end())
    {
        ++curr;
        int diff = std::abs(*start - *curr);
        if(diff == reference)
        {
            std::cout << "1 as " << *start << " - " << *curr << " = " << diff << std::endl;
            return;
        }
        else if (diff > reference)
        {
            ++start;
            curr = start;
        }
    }
    std::cout << "0" << std::endl;
}

int main()
{
    std::vector<std::pair< int, std::vector<int>>> tests { 
        {7, {50, 8, 12, 15, 5} },
        {6, {1, 5, 2, 9, 7} },
        {15, {10, 30, 20, 50, 40} },
        {15, {-15, -5, -30, 20, 50, 40} }
    };

    for (auto test : tests)
    {
        pair_diff(test.first, test.second);
    }
}