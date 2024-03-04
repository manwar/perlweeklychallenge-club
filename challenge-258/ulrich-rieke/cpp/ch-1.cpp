#include <vector>
#include <string>
#include <algorithm>
#include <iterator>
#include <iostream>

int main( ) {
   std::cout << "Enter some integers, separated by spaces!\n" ;
   std::cout << "Enter 'e' to end entry!\n" ;
   std::vector<int> numbers { std::istream_iterator<int>{ std::cin } , 
      std::istream_iterator<int>{} } ;
   std::vector<std::string> numberstrings ;
   for ( int i : numbers ) 
      numberstrings.push_back( std::to_string( i ) ) ;
   std::cout << std::count_if( numberstrings.begin( ) , numberstrings.end( ),
	 []( auto s ) { return s.length( ) % 2 == 0 ; } ) << '\n' ;
   return 0 ;
}
