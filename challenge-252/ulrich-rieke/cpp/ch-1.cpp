#include <vector>
#include <iostream>
#include <algorithm>
#include <iterator>

int main( ) {
   std::cout << "Enter some integers , separated by blanks, end to end!\n" ;
   std::vector<int> numbers { std::istream_iterator<int>{ std::cin } , 
      std::istream_iterator<int>{} } ;
   int sum = 0 ;
   int len = numbers.size( ) ;
   for ( int i = 0 ; i < len ; i++ ) {
      if ( len % ( i + 1 ) == 0 ) 
	 sum += numbers[ i ] * numbers[ i ] ;
   }
   std::cout << sum << '\n' ;
   return 0 ;
}
