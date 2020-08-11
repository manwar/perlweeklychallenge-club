/**
* Create a script that accepts one or more files 
* specified on the command-line and count the 
* number of times letters appeared in the files.
**/
#include <map>
#include <cctype>
#include <vector>
#include <iostream> 

int main(int argc, char** argv){
    std::string input; 
    std::vector<std::pair<char, int>> v; 
    std::map<char, int> letter_counts; 
    do{ 
        getline(std::cin, input);
        if(!input.empty()){
            for(char letter: input){
                letter = tolower(letter); 
                if(letter != ' ' && letter != '\t' && letter != '\n' && letter != '.'){
                    if(letter_counts.find(letter) != letter_counts.end()){
                        letter_counts[letter] += 1;
                    }
                    else{
                        letter_counts[letter] = 1; 
                    } 
                }  
            } 
        }  
    }while(!input.empty());   
    std::copy(letter_counts.begin(), letter_counts.end(), std::back_inserter<std::vector<std::pair<char, int>>>(v));
    std::vector<std::pair<char, int>>::iterator iter = v.begin();
    while(iter != v.end()){
        std::cout << iter->first << ": " << iter->second << std::endl; 
        iter++; 
    }  
}
