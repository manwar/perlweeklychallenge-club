#include <iostream>
#include <vector>
#include <iterator>
#include <algorithm>

int main( ) {
   std::cout << "Enter some integers, separated by blanks!\n" ;
   std::cout << "Enter e to end entry!\n" ;
   std::vector<int> numbers { std::istream_iterator<int>{ std::cin } , 
      std::istream_iterator<int>{} } ;
   std::vector<int> result ;
   for ( int i : numbers ) {
      result.push_back( std::count_if( numbers.begin( ) , numbers.end( ) , 
	       [i]( int n ) { return n < i ; } ) ) ;
   }
   std::cout << "( " ;
   std::copy( result.begin( ) , result.end( ) ,
	 std::ostream_iterator<int>( std::cout , " " )) ;
   std::cout << ")\n" ;
   return 0 ;
}
