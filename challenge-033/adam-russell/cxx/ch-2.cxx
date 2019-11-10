#include <iostream>

int main(int argc, char **argv){
    std::cout << "     x|   1   2   3   4   5   6   7   8   9   10   11" << std::endl;
    std::cout << "   ---+----------------------------------------------" << std::endl;
    for(int x = 1; x <= 11; x++){
        std::cout.width(6); std::cout << x << "|";
        for(int y = 1; y <= 11; y++){
            if(y < x){
                std::cout.width(4); std::cout << std::right << " ";
            }
            else{
                if(y < 10){
                    std::cout.width(4); std::cout << std::right << x*y;
                }
                else{
                    std::cout.width(5); std::cout << std::right << x*y;
                }
            }
        }
        std::cout << std::endl;
    }
}
