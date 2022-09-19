#include<map>
#include<vector>
#include<iostream>

class PermutedMultiple{
    private:
        bool is_permuted(int, int);
        std::vector<int> int2digits(int);
    public:
        int smallest_permuted();
};

std::vector<int> PermutedMultiple::int2digits(int i){
    std::vector<int> digits;
    do{
        int digit = i % 10;
        digits.push_back(digit);
        i = i / 10;  
    }while(i != 0); 
    return digits;  
}

bool PermutedMultiple::is_permuted(int x, int y){
    std::vector<int> x_digits = this->int2digits(x);
    std::vector<int> y_digits = this->int2digits(y);
    std::map<int, int> x_counts;
    std::map<int, int> y_counts;
    for(int i = 0; i < x_digits.size(); i++){
        if(x_counts.find(x_digits[i]) != x_counts.end()){
            int count = x_counts.at(x_digits[i]);
            count++;
            x_counts.at(x_digits[i]) = count;
        }
        else{
            x_counts.insert(std::pair<int,int>(x_digits[i], 1));
        }
    }
    for(int i = 0; i < y_digits.size(); i++){
        if(y_counts.find(y_digits[i]) != y_counts.end()){
            int count = y_counts.at(y_digits[i]);
            count++;
            y_counts.at(y_digits[i]) = count;
        }
        else{
            y_counts.insert(std::pair<int,int>(y_digits[i], 1));
        }
    }
    return x_counts == y_counts;
}

int PermutedMultiple::smallest_permuted(){
    int x = 0;
    do{
        x++;
    }while(!(this->is_permuted(x, 2*x) && this->is_permuted(2*x, 3*x) && this->is_permuted(3*x, 4*x) &&
             this->is_permuted(4*x, 5*x) && this->is_permuted(5*x, 6*x)));
    return x;
}

int main(int argc, char** argv){
    PermutedMultiple permuted;
    std::cout << permuted.smallest_permuted() << std::endl;   
} 