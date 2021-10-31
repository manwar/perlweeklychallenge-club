#include <iostream>
using namespace std;

int main() {
    int n=5;
    int ptr[]={10,20,30,40,50};
    int sum = 0;
    for (int j = 1; j <= n; j++) {
        sum += ptr[j-1];
        int k= sum/j; 
        cout<<k;
        cout<<endl;
    }
    cout<<endl;
    
    return 0;
}