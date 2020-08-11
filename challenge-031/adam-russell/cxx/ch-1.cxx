#include <iostream>
#include <cstdlib>
#include <csignal> 
using namespace std;

void handler(int){
    cerr << "caught an error";
    exit(1); 
} 

int main () {
    if(SIG_ERR == signal(SIGFPE, handler)){
        cerr << "could not setup SIGFPE handler";
        return 1;  
    } 
    int x = 9, y = 0;
    float z = x % y;
    cout << z << endl;
    return 0;
}
