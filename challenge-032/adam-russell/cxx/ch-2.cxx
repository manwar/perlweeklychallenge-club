/**
* Write a function that takes a hashref where the keys
* are labels and the values are integer or floating
* point values. Generate a bar graph of the data and
* display it to stdout.
**/ 
#include <map>
#include <vector> 
#include <iostream>
#include "boost/foreach.hpp"
#include "boost/property_tree/json_parser.hpp"

#define MAX_LENGTH 10

int main(int argc, char** argv){
    int max, min; 
    std::map<std::string, int> counts; 
    std::stringstream s;
    std::string input(argv[1]);
    std::vector<std::pair<std::string, int>> v;
    s << input; 
    boost::property_tree::ptree json_tree;
    boost::property_tree::read_json(s, json_tree); 
    BOOST_FOREACH(boost::property_tree::ptree::value_type &v, json_tree){
        counts[v.first.data()] = stoi(v.second.data());  
    }
    std::copy(counts.begin(), counts.end(), std::back_inserter<std::vector<std::pair<std::string, int>>>(v));
    std::sort(v.begin(), v.end(),[](const std::pair<std::string, int> &l, const std::pair<std::string, int> &r){
        if(l.second != r.second)
            return l.second > r.second;
        return l.first > r.first;
    });    
    std::map<std::string,int>::iterator find_max = std::max_element(counts.begin(),counts.end(),[] (const std::pair<std::string,int>& a, const std::pair<std::string,int>& b)->bool{ return a.second < b.second; } );
    std::map<std::string,int>::iterator find_min = std::min_element(counts.begin(),counts.end(),[] (const std::pair<std::string,int>& a, const std::pair<std::string,int>& b)->bool{ return a.second < b.second; } );
    max = find_max->second;  
    min = find_min->second;  
    std::vector<std::pair<std::string, int>>::iterator iter = v.begin();
    while(iter != v.end()){
        float scaled = (iter->second - min + 1.0) / (max - min); 
        std::string bar ((int)(scaled*MAX_LENGTH),'#');
        std::cout << iter->first << "\t|" << bar << std::endl;
        iter++;
    }
} 
