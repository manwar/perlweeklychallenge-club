#include<iostream>
#include<vector>
#include<algorithm>

class MultiplicationTable{
    public:
        int nth_from_table(int, int, int);
};

int MultiplicationTable::nth_from_table(int i, int j, int k){
    std::vector<int> table;
    for(int x = 1; x <= i; x++){
        for(int y = 1; y <= j; y++){
            table.push_back(x * y);  
        }   
    }   
    std::sort(table.begin(), table.end());
    return table.at(k - 1);  
} 


int main(int argc, char** argv){
    int n;
    MultiplicationTable mt;
    n = mt.nth_from_table(2, 3, 4);
    std::cout << n << std::endl; 
    n = mt.nth_from_table(3, 3, 6);
    std::cout << n << std::endl; 
}  
