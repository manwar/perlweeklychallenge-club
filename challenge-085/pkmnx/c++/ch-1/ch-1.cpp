#include <vector>
#include <map>
#include <iostream>
#include <bits/stdc++.h>

using namespace std;
 
void permute( vector<double> v ) {

   sort( v.begin(), v.end() );

   map<double, map <double, map <double, bool> > > m;

   do {

      double a = v[0];
      double b = v[1];
      double c = v[2];

      if ( m[ a ][ b ][ c ] ) {
         // nothing ...

      } else {

         m[ a ][ b ][ c ] = true;

         double sum = a + b + c;
         if ( sum > 1 && sum < 2 ) {
            cout << "Output: 1 as 1 < " << a << " + " << b << " + " << c <<  " < 2" << endl;
            exit(0);
         }

      }

   } while ( next_permutation( v.begin(), v.end() ) );

}
 
int main() {

   vector<double> v;

   double x;
   while ( cin >> x ) { v.push_back(x); }

   if ( v.size() > 0 ) {

      cout << "Input: @R = (" << v[0];

      for ( std::vector<double>::size_type i = 1; i < v.size(); i++ ) {
         cout << ", " << v[i];
      }
 
      cout << ")" << endl;

      permute(v);

   }

   cout << "Output: 0\n";

   return 0;

}
