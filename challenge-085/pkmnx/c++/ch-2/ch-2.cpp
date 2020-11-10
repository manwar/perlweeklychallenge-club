#include <bits/stdc++.h>
#include <iostream>
#include <math.h>

using namespace std;

int main() {

   long n;
   cin >> n;

   if ( n < 0 ) { 
      cout << "Input: " << n << " is not positive." << endl;
      exit(0);
   }
   if ( n > INT_MAX ) { 
      cout << "Input: " << n << " is greater than INT_MAX: " << INT_MAX << endl;
      exit(0);
   }

   cout << "Input: " << n << endl;

   for ( int i = 2; i <= n; ++i ) {
      if ( n % i == 0 ) {

         for ( int j = 2; j < INT_MAX; j++ ) {

            long ij = 1;
            for ( int k = 0; k < j; k++ ) {
               ij *= i;
               if ( ij > n ) { break; }
            }
            if ( ij > n ) { break; }

            if ( ij == n ) {
               cout << "Output: 1 as " << n << " = " << i << " ^ " << j << endl;
               exit(0);
            }

         }
      
      }
   }

   cout << "Output: 0" << endl;
   return 0;
}
