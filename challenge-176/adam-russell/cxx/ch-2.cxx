#include<map>
#include<vector>
#include<iostream>
#include<algorithm>

class ReversibleNumber{
    private:
        bool is_reversible(int);
        int vector2int(std::vector<int>);
        std::vector<int> int2digits(int);
    public:
        std::vector<int> reversibles_under_n(int);
};

std::vector<int> ReversibleNumber::int2digits(int i){
    std::vector<int> digits;
    do{
        int digit = i % 10;
        digits.push_back(digit);
        i = i / 10;  
    }while(i != 0); 
    return digits;  
}

int ReversibleNumber::vector2int(std::vector<int> v){
    int x = 1; 
    int r = 0;
    for(int i: v){
        r = r + (i * x);
        x = x * 10;   
    }
    return r; 
}

bool ReversibleNumber::is_reversible(int x){
    std::vector<int> x_digits = this->int2digits(x);
    std::reverse(x_digits.begin(), x_digits.end());
    int sum = x + this->vector2int(x_digits);
    std::vector<int> sum_digits = this->int2digits(sum);
    for(int i = 0; i < sum_digits.size(); i++)
        if(sum_digits[i] % 2 == 0)
            return false;
    return true;
}
   
std::vector<int> ReversibleNumber::reversibles_under_n(int n){
    std::vector<int> reversibles;
    do{
        n--;
        if(is_reversible(n)){
            reversibles.push_back(n); 
        }
            
    }while(n > 0);
    std::reverse(reversibles.begin(), reversibles.end());
    return reversibles;
}

int main(int argc, char** argv){
    ReversibleNumber reversible;
    std::vector<int> reversibles = reversible.reversibles_under_n(100);
    for(int i = 0; i < reversibles.size() - 1; i++)
        std::cout << reversibles[i] << ", "; 
    std::cout << reversibles[reversibles.size() - 1] << std::endl;
}     