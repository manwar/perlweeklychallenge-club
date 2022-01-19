// The Weekly Challenge 147
// Task 1 Truncatable Prime
// g++ ch-1.cpp -o ch-1.o
// Friday, January 14, 2022 PM01:15:37 HKT

#include <vector>
#include <cmath>
#include <algorithm>
#include <iostream>

using namespace std;
vector<int> ltp = {};
vector<int> recent_ltp = {2, 3, 5, 7};
vector<int> new_ltp = {};
vector<int> primes = {2, 3, 5, 7};

bool is_prime(int t) {
    for (int k = 0; primes.at(k) <= sqrt(t); k++) {
        if (t % primes.at(k) == 0)
            return false;
    }
    return true;
}



void append_primes(int max) {
    for (int can = primes.back()+1; can <= max; can++) {
        bool good = true;
        for (int k = 0; primes.at(k) <= sqrt(can) & good; k++ ) {
            if (can % primes.at(k) == 0)
                good = false;
        }
        if (good)
            primes.push_back(can); 
    }
}



void append_ltp(int target_size) {
    if (target_size <= ltp.size() + recent_ltp.size() ) {
        ltp.insert( ltp.end(), recent_ltp.begin(), recent_ltp.end() );
        return;
    }
    for (int d = 1; d <= 9; d++) {
        for (int r = 0; r < recent_ltp.size(); r++ ) {
            char str[20];
            int num = recent_ltp.at(r);
            sprintf(str, "%d%d", d, num);
            int new_num = atoi(str);
            if (is_prime(new_num)) 
                new_ltp.push_back(new_num);
        }
    }
    ltp.insert( ltp.end(), recent_ltp.begin(), recent_ltp.end() );
    recent_ltp = new_ltp;
    new_ltp = {};
    append_ltp(target_size);
}



int main() {
    append_primes(1000);
    append_ltp(20);
    for (int i = 0; i < 20; i++) {
        cout << ltp.at(i) << endl;
    }
    return 0;
}
