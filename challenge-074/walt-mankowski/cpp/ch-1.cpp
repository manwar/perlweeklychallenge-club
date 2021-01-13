#include <stdlib.h>
#include <iostream>
#include <map>

using namespace std;

int main(int argc, char *argv[]) {
    int target = (argc-1) / 2;
    int result = -1;
    map<int,int> cnt;

    for (int i = 1; i < argc; i++) {
        int x = atoi(argv[i]);
        if (++cnt[x] > target) {
            result = x;
            break;
        }
    }

    cout << result << endl;
}


    
