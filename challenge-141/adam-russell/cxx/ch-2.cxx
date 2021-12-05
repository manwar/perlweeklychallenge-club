#include<vector>
#include<iostream>
#include<algorithm>

class LikeNumbers{
    public:
        std::vector<int> like_numbers(int, int);  
    private:
        std::vector<int> int2digits(int);
};

std::vector<int> LikeNumbers::int2digits(int i){
    std::vector<int> digits;
    do{
        int digit = i % 10;
        digits.push_back(digit);
        i = i / 10;  
    }while(i != 0); 
    std::reverse(digits.begin(), digits.end()); 
    return digits;  
}

std::vector<int> LikeNumbers::like_numbers(int i, int j){
    std::vector<int> digits = this->int2digits(i);  
    for(int digit : digits)
        std::cout << digit << " "; 
    std::cout << std::endl; 
    return digits;
}

int main(int argc, char** argv){
    LikeNumbers ln;
    ln.like_numbers(1234, 2);  
} 
