/**
* Create a script that either reads standard input
* or one or more files specified on the command-line.
* Count the number of times and then print a summary,
* sorted by the count of each entry.
**/
#include <map>
#include <vector>
#include <string> 
#include <iostream> 
#include <algorithm> 
int main(int argc, char** argv){
    std::string input; 
    std::vector<std::pair<std::string, int>> v; 
    std::map<std::string, int> word_counts; 
    do{ 
        getline(std::cin, input);
        if(word_counts.find(input) != word_counts.end()){
            word_counts[input] += 1;
        }
        else{
            if(!input.empty()) 
                word_counts[input] = 1;
        } 
    }while(!input.empty());  
    std::copy(word_counts.begin(), word_counts.end(), std::back_inserter<std::vector<std::pair<std::string, int>>>(v));
    std::sort(v.begin(), v.end(),[](const std::pair<std::string, int> &l, const std::pair<std::string, int> &r){
        if(l.second != r.second)
            return l.second > r.second;
        return l.first > r.first;
    }); 

    std::vector<std::pair<std::string, int>>::iterator iter = v.begin();
    while(iter != v.end()){
        std::cout << iter->first << "\t" << iter->second << std::endl; 
        iter++; 
    }  
} 
