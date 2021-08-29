#include <vector>
#include <iostream>
#include <algorithm> 
/*
 * You are given two sets with unique numbers.
 * Write a script to figure out if they are disjoint. 
*/   
class DisjointSets{
    public:
        bool disjoint(std::vector<int>, std::vector<int>);   
};     

bool DisjointSets::disjoint(std::vector<int> v0, std::vector<int> v1){
    bool found = false; 
    std::for_each(v0.begin(), v0.end(), 
        [&v1, &found](int &n){ 
            if(std::find(v1.begin(), v1.end(), n) != v1.end())  
                found = true;    
        }
    );  
    return !found;  
}

int main(int argc, char** argv){
    std::vector<int> v0 {1, 2, 5, 3, 4};  
    std::vector<int> v1 {4, 6, 7, 8, 9};  
    DisjointSets ds;
    std::cout << ds.disjoint(v0, v1) << std::endl;  
    std::vector<int> v2 {1, 3, 5, 7, 9};  
    std::vector<int> v3 {0, 2, 4, 6, 8};  
    std::cout << ds.disjoint(v2, v3) << std::endl;  
}
