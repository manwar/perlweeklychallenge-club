#include <vector>
#include <iostream>
#include <algorithm>
/*
 * You are given a list of intervals. Write a script
 * to determine conflicts between the intervals.
*/ 
class ConflictIntervals{
    public:
        std::vector<std::vector<int>> conflicts(std::vector<std::vector<int>>);     
};  

std::vector<std::vector<int>> ConflictIntervals::conflicts(std::vector<std::vector<int>> v){
    std::vector<std::vector<int>> conflicts;    
    std::sort(v.begin(), v.end(),
          [](const std::vector<int> &a, const std::vector<int> &b) {
              return a[1] < b[1];
          }
    );
    for(int i = v.size() - 1; i >= 0; i--){
        for (int j = 0; j < i; j++){
            if(v[i][0] >= v[j][0] && v[i][0] <= v[j][1]){  
                conflicts.push_back(v[i]);            
                break; 
            } 
        }
    }  

    return conflicts; 
}

int main(int argc, char** argv){
    std::vector<std::vector<int>> intervals = {{1, 4}, {3, 5}, {6, 8}, {12, 13}, {3, 20}};  
    ConflictIntervals ci;
    std::vector<std::vector<int>> conflicts = ci.conflicts(intervals);  
    for(int i=0; i < conflicts.size(); i++){
        std::cout << "[" << conflicts[i][0] << ", " << conflicts[i][1] <<  "]" << " ";  
    }
    std::cout << std::endl;   
    intervals = {{3, 4}, {5, 7}, {6, 9}, {10, 12}, {13, 15}};  
    conflicts = ci.conflicts(intervals);  
    for(int i=0; i < conflicts.size(); i++){
        std::cout << "[" << conflicts[i][0] << ", " << conflicts[i][1] <<  "]" << " ";
    }
    std::cout << std::endl;   
}
