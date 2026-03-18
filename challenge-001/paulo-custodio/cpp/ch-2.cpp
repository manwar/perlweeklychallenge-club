// Perl Weekly Challenge 001 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-001/

#include <iostream>
#include <cstdlib>

int main(int argc, char* argv[]) {
    if (argc == 2) {
        int n = atoi(argv[1]);
        for (int i = 1; i <= n; i++) {
            if (i%15==0)
                std::cout << "fizzbuzz" << std::endl;
            else if (i%3==0)
                std::cout << "fizz" << std::endl;
            else if (i%5==0)
                std::cout << "buzz" << std::endl;
            else
                std::cout << i << std::endl;
        }
    }
}
