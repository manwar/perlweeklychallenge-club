#include <iostream>

int count_bits(int n){
    int set_bits = 0;
    for(int i = 1; i <= n; i++){
        int x = i;
        while(x > 0){
            int b = x & 1;
            set_bits += b;
            x = x >> 1;
        }
    }
    return set_bits;
}

int main(int argc, char** argv){
    int set_bits = count_bits(3);
    std::cout << set_bits << " % 1000000007 = " << set_bits % 1000000007 << std::endl;
    set_bits = count_bits(4);
    std::cout << set_bits << " % 1000000007 = " << set_bits % 1000000007 << std::endl;
}