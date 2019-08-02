#include "perfect.h"

Perfect::Perfect(){
}  

Perfect::~Perfect(){
}  

bool Perfect::isPerfect(int n){
    long int sum = 1;

    // Find all divisors and add them
    for (long int i=2; i*i<=n; i++){
        if (n%i==0){
            if(i*i!=n)
                sum = sum + i + n/i;
            else
                sum=sum+i;
        }
    }
    if (sum == n && n != 1){ 
          return true;
    }
     return false;
}   
