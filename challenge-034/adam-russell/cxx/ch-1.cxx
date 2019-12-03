/**
* Write a program that demonstrates using hash slices and/or array slices.
**/
#include <map>
#include <vector> 
#include <string>
#include <iostream>
#include <algorithm> 
#include <iterator> 

void print_element(std::string s){
    if(s != "")
        std::cout << s << std::endl; 
}

int main(int argc, char** argv){ 
    std::vector<int> v {2, 4}; 
    std::map<int, std::string> mapExp = { {1, "first"}, {2, "second"}, {3, "third"}, {4,"fourth"} };
    std::vector<std::string> vValue;
    std::transform(mapExp.begin(), mapExp.end(), std::back_inserter(vValue),
       [=](const std::pair<int, std::string> &mapItem){
             std::vector<int>::const_iterator iter = std::find(v.begin(), v.end(), mapItem.first);
             if(iter != v.end())
                 return mapItem.second;
             return std::string("");
       });
    std::for_each(vValue.begin(), vValue.end(), print_element);  
}
