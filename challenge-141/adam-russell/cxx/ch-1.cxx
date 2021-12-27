#include<cmath>
#include<vector>
#include<iostream>

class NumberDivisors{
    private:
        std::vector<int> factor(int);
    public:
        std::vector<int> first_ten_with_eight(); 
};  

std::vector<int> NumberDivisors::factor(int n){
    std::vector<int> factors;
    factors.push_back(1);
    factors.push_back(n);
    for(int i = 2; i <= std::sqrt(n); i++){
        if(n % i == 0)
            factors.push_back(i);
        if(n % i == 0 && std::lround(std::pow(i,2)) != n)
            factors.push_back(n / i); 
    }  
    return factors;
}

std::vector<int> NumberDivisors::first_ten_with_eight(){
    int i = 0;
    std::vector<int> divisible;
    do{
        std::vector<int> factors = this->factor(i);
        if(factors.size() == 8) 
            divisible.push_back(i);
        i++;   
    }while(divisible.size() < 10);    
    return divisible;  
}

int main(int argc, char** argv){
    NumberDivisors divisorator;
    std::vector<int> first_ten = divisorator.first_ten_with_eight();
    for(int i : first_ten)
        std::cout << i << " "; 
    std::cout << std::endl;  
}
