/*
Challenge 006

Challenge #1
Create a script which takes a list of numbers from command line and print the
same in the compact form. For example, if you pass "1,2,3,4,9,10,14,15,16"
then it should print the compact form like "1-4,9,10,14-16".
*/

#include <iostream>
#include <sstream>
#include <string>
#include <vector>
using namespace std;

vector<int> nums;

void parse_nums(const string& str) {
    istringstream iss(str);
    string num_str;
    while (getline(iss, num_str, ',')) {
        int num = atoi(num_str.c_str());
        nums.push_back(num);
    }
}

int main(int argc, char* argv[]) {
    if (argc != 2) return EXIT_FAILURE;
    parse_nums(argv[1]);
    for (size_t i = 0; i < nums.size(); i++) {
        cout << nums[i];
        if (i + 2 < nums.size() &&
            nums[i + 1] == nums[i] + 1 &&
            nums[i + 2] == nums[i] + 2) {
            size_t j = 0;
            while (i + j < nums.size() && nums[i + j] == nums[i] + j)
                j++;
            i += j - 1;
            cout << "-" << nums[i];
        }
        if (i + 1 < nums.size())
            cout << ",";
    }
    cout << endl;
}
