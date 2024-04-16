#include <vector>
#include <iterator>
#include <iostream>
#include <algorithm>
#include <ranges>
#include <list> 

namespace rng = std::ranges ;

int main( ) {
   std::cout << "Enter some integers, separated by blanks, e to end!\n" ;
   std::vector<int> numbers { std::istream_iterator<int>{ std::cin } , 
      std::istream_iterator<int>{} } ;
   std::vector<int> selected ;
   int len = numbers.size( ) ;
   std::list<int> someNumbers { numbers.begin( ) , numbers.end( ) } ;
   someNumbers.unique( ) ;
   for ( int i : someNumbers ) {
      int howmany = std::count( numbers.begin( ) , numbers.end( ) , i ) ;
      if ( static_cast<double>( howmany ) >= ( len / 3.0 ) ) 
	 selected.push_back( i ) ;
   }
   if ( selected.size( ) > 0 ) {
      rng::sort( selected ) ;
      std::cout << *selected.begin( ) << '\n';
   }
   else 
      std::cout << "undef\n" ;
   return 0 ;
}
