#include <iostream>    
#include <algorithm>    
#include <vector>       
/*
* You are given an unsorted list of integers @N.
* Write a script to find out the smallest positive number missing.
*/
int least_missing(int n[]){
    std::sort (n, n + 4);
    std::vector<int> numbers (n, n + 4);  
    for(int i = n[0]; i < n[3]; i++){
        std::vector<int>::iterator itr = std::find(numbers.begin(), numbers.end(), i);
        if (itr == std::end(numbers)) {
            if(i > 0)
                return i;
        }
    }
    return -1;
}

int main(int argc, char** argv){
    int N[4] = {5, 2, -2, 0};
    int i = least_missing(N);
    std::cout << "the least positive missing number is " << i << std::endl;
}