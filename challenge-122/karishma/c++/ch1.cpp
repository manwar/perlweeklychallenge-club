#include <iostream>
using namespace std;

int main() {
    int n=5;
    int ptr[]={10,20,30,40,50};
   //int* ptr;
    // cout<<"Enter total number of inputs to be entered: ";
    // cin>>n;
    // ptr = (int*)calloc(n, sizeof(int));
    // if (ptr == NULL) {
    //     cout<<"Memory not allocated.\n";
    //     exit(0);
    // }
    // else {
    //     for (int i = 1; i <= n; i++) {
    //         int temp=0;
    //         scanf("%d",&temp);
    //         ptr[i] = temp;
    //     }
    //     cout<<endl;
    // }
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