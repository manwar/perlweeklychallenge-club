#include<cmath>
#include<vector>
#include<iostream>
#include<algorithm>

class LikeNumbers{
    public:
        std::vector<int> like_numbers(int, int);  
    private:
        int vector2int(std::vector<int>);
        std::vector<int> int2digits(int);
};

std::vector<int> LikeNumbers::int2digits(int i){
    std::vector<int> digits;
    do{
        int digit = i % 10;
        digits.push_back(digit);
        i = i / 10;  
    }while(i != 0); 
    return digits;  
}

int LikeNumbers::vector2int(std::vector<int> v){
    int x = 1; 
    int r = 0;
    for(int i: v){
        r = r + (i * x);
        x = x * 10;   
    }
    return r; 
}

std::vector<int> LikeNumbers::like_numbers(int i, int j){
    std::vector<int> digits = this->int2digits(i);  
    std::vector<int> like;
    int power_set_size = std::pow(2, digits.size()); 
    for(int k = 1; k < power_set_size - 1; k++){
        std::vector<int> included_digits;
        for(int l = 0; l < digits.size(); l++){
            if( k >> l & 1) 
                included_digits.push_back(digits.at(l));
        }
        int number = this->vector2int(included_digits);  
        if(number % j == 0) 
            like.push_back(number); 
    }
    std::sort(like.begin(), like.end()); 
    return like;
}

int main(int argc, char** argv){
    LikeNumbers ln;
    std::vector<int> like;
    like = ln.like_numbers(1234, 2);  
    std::cout << like.size() << ": ";
    for(int i : like){
        std::cout << i << " ";
    } 
    std::cout << std::endl;     
    like = ln.like_numbers(768, 4);
    std::cout << like.size() << ": ";
    for(int i : like){
        std::cout << i << " ";
    } 
    std::cout << std::endl;     
} 
