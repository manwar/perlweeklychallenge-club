#include <iostream>
#include <algorithm>
#include <vector>
#include <iterator>

//unfortunately, my compiler neither supports the function popcount,
//defined in <bit> , nor the header file <format> , defined in C++20!
//So I have to come up with this helper function!
std::vector<int> toBinary( int n ) {
   std::vector<int> digits ;
   while ( n != 0 ) {
      digits.push_back( n % 2 ) ;
      n /= 2 ;
   }
   return digits ;
}

int main( ) {
   //I reverse the order of data entry in order to preserve the beautiful
   //way of entering a vector of integers by simply invoking the
   //constructors of an input stream!
   std::cout << "Enter an integer k!\n" ;
   int k ;
   std::cin >> k ;
   std::cout << "Enter some integers, separated by spaces!\n" ;
   std::cout << "Enter 'e' to end entry!\n" ;
   std::vector<int> numbers {std::istream_iterator<int>{std::cin} , 
      std::istream_iterator<int>{} } ;
   int sum = 0 ;
   for ( int i = 0 ; i < numbers.size( ) ; i++ ) {
      std::vector<int> digits { toBinary( i ) } ;
      if ( std::count( digits.begin( ) , digits.end( ) , 1 ) == k ) 
	 sum += numbers[i] ;
   }
   std::cout << sum << '\n' ;
   return 0 ;
}
