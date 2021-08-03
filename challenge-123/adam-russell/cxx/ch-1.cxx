#include <vector>
#include <iostream>

/* 
 * You are given an integer n >= 1.
 * Write a script to find the nth Ugly Number.
*/

class Ugly{
    private:
        std::vector<int> factor(int);   
        bool is_ugly(int);
    public:
        int nth_ugly(int); 
};     

std::vector<int> Ugly::factor(int n){
    std::vector<int> factors;  
    for (int i=2; i*i<=n; i++){
        if (n%i==0){
            if(i*i!=n){  
                factors.push_back(i);
                factors.push_back(n/i);
            }
            else
                factors.push_back(i);
        }
    }
    return factors;  
}

bool Ugly::is_ugly(int n){
    std::vector<int> factors = this->factor(n);
    for(int i = 0; i < factors.size(); i++){
        if(factors[i] != 2 && factors[i] != 3 && factors[i] != 5)
            return false; 
    }    
    return true;   
} 

int Ugly::nth_ugly(int n){
    int ugly_count = 1; 
    int i = 2; 
    if(n == 1)
        return 1; 
    do{
        if(is_ugly(i))
            ugly_count++;  
        i++;  
    }while(ugly_count != n); 
    return i; 
} 

int main(int argc, char** argv){
    Ugly ugly;
    int u = ugly.nth_ugly(10);   
    std::cout << u << std::endl;
}
