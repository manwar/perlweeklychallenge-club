#include<iostream>
#include<vector>
#include<algorithm>

class AddBinary{
    public:
        int add_binary(int, int);  
    private:
        std::vector<int> int2vector(int);       
        int vector2int(std::vector<int>);       
}; 

std::vector<int> AddBinary::int2vector(int i){
    std::vector<int> v;  
    while(i > 0){
        int m = i % 10;
        i = i / 10;
        v.push_back(m);   
    } 
    return v;  
}

int AddBinary::vector2int(std::vector<int> v){
    int x = 1; 
    int r = 0;
    for(int i: v){
        r = r + (i * x);
        x = x * 10;   
    }
    return r; 
}

int AddBinary::add_binary(int a, int b){
    std::vector<int> va = this->int2vector(a); 
    std::vector<int> vb = this->int2vector(b); 
    std::vector<int> sum;  
    int carry = 0;  
    std::reverse(va.begin(), va.end());
    for(int i=va.size() - 1; i >=0; i--){
        int d0 = va.at(i);
        if(!vb.empty()){
            int d1 = vb.back();
            vb.pop_back();
            if(carry == 0){
                if(d0 == 1 && d1 == 0){
                    sum.push_back(1);
                    carry = 0;  
                }  
                if(d0 == 1 && d1 == 1){
                    sum.push_back(0);
                    carry = 1;  
                }  
                if(d0 == 0 && d1 == 0){
                    sum.push_back(0);
                    carry = 0;  
                }
                if(d0 == 0 && d1 == 1){
                    sum.push_back(1);
                    carry = 0;  
                }
            }
            else{
                if(d0 == 1 && d1 == 1){
                    sum.push_back(0);
                    carry = 0; 
                } 
                if(d0 == 0 && d1 == 1){
                    sum.push_back(0);
                    carry = 1;
                } 
                if(d0 == 0 && d1 == 0){
                    sum.push_back(1);
                    carry = 0;
                } 
                if(d0 == 1 && d1 == 0){
                    sum.push_back(0);
                    carry = 1;
                } 
            } 
        }
        else{
            if(d0 == 1 && carry == 1){
                sum.push_back(0);
                carry = 1;
            } 
            else if(d0 == 0 && carry == 1){
                sum.push_back(1);
                carry = 0;
            } 
            else if(d0 == 0 && carry == 0){
                sum.push_back(0);
                carry = 0;
            } 
            else if(d0 == 1 && carry == 0){
                sum.push_back(1);
                carry = 0;
            } 
        }
    }  
    if(carry == 1)
        sum.push_back(1);
    return this->vector2int(sum);   
}


int main(int argc, char** argv){
    int x; 
    AddBinary ab; 
    x = ab.add_binary(11, 1);  
    std::cout << x << std::endl;  
    x = ab.add_binary(101, 1);  
    std::cout << x << std::endl;   
    x = ab.add_binary(100, 11);  
    std::cout << x << std::endl;  
}
