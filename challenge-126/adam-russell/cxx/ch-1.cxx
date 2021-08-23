#include <iostream>

/* 
 * You are given a positive integer n.
 * Write a script to print the count of 
 * numbers from 1 to n that don't contain digit the 1. 
*/

class CountNumbers{
    private:
        int has_1(int);   
        int count_with_1(int);
    public:
        int count_without_1(int);
};     

int CountNumbers::has_1(int n){
    std::string s = std::to_string(n);  
    const char* c = s.c_str();
    while(*c != '\0'){
        if(*c == '1')
            return 1;
        c++;
    } 
    return 0;
}

int CountNumbers::count_with_1(int n){
    int count = 0;
    for(int i = 1; i <= n; i++)
        count += has_1(i);  
    return count; 
}

int CountNumbers::count_without_1(int n){
    return n - count_with_1(n);  
}

int main(int argc, char** argv){
    CountNumbers cn;
    int n;
    n = 15; 
    std::cout << cn.count_without_1(n) << std::endl;
    n = 25; 
    std::cout << cn.count_without_1(n) << std::endl;
}

