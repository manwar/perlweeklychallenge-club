

#include<iostream>
#include<vector>
#include<algorithm>
/*
* Write a script to generate first 5 Pandigital Numbers in base 10.
*/


class Pandigital {
    public:
        std::vector<int> first_n_pandigitals(int);
        std::vector<int> first_5_pandigitals();
};


std::vector<int> Pandigital::first_n_pandigitals(int n) {
    std::vector<int> pandigitals;
    int x = 1000000000;
    do {
        int test = x;
        std::vector<int> test_vector = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9};
        do {
            test_vector.erase(std::remove(test_vector.begin(), test_vector.end(), test % 10), test_vector.end());
            test = test / 10;
        } while(test > 0);
        if(test_vector.size() == 0)
            pandigitals.push_back(x);
        x++;
    } while(pandigitals.size() < n);
    return pandigitals;
}


std::vector<int> Pandigital::first_5_pandigitals() {
    return this->first_n_pandigitals(5);
}


int main(int argc, char** argv) {
    Pandigital p;
    std::vector<int> pandigitals = p.first_5_pandigitals();
    for(int i = 0; i < pandigitals.size(); i++) {
        std::cout << pandigitals[i] << std::endl;
    }
}

