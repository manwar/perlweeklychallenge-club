#include<vector>
#include<iostream>

class DotProduct{
    public:
        int dot_product(std::vector<int>, std::vector<int>);
};

int DotProduct::dot_product(std::vector<int> a, std::vector<int> b){
    if(a.empty() && b.empty()){
        return 0;
    }
    int s = a.back();
    a.pop_back();
    int t = b.back();
    b.pop_back();
    return s * t + this->dot_product(a, b);
}

int main(int argc, char** argv){
    DotProduct dp;
    std::vector<int> a = {1, 2, 3};
    std::vector<int> b = {4, 5, 6};
    std::cout << dp.dot_product(a, b) << std::endl;
}