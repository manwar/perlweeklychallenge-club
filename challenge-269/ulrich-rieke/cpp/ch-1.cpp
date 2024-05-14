#include <iostream>
#include <string>
#include <ranges>
#include <string_view>
#include <algorithm>
#include <list>
#include <iterator>
#include <vector>

int main( ) {
   std::cout << "Enter some distinct integers, separated by blanks!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   std::vector<std::string> numberstrings ;
   char delimiter = ' ' ;
   auto split = line | std::views::split( delimiter ) ;
   for ( const auto & subrange : split ) {
      std::string numstring( &*subrange.begin( ) , std::ranges::distance( 
	       subrange ) ) ;
      numberstrings.push_back( numstring ) ;
   }
   std::list<int> numbers , arr1 , arr2 ;
   for ( auto s : numberstrings ) 
      numbers.push_back( std::stoi( s ) ) ;
   int first = numbers.front( ) ;
   arr1.push_back( first ) ;
   numbers.pop_front( ) ;
   first = numbers.front( ) ;
   arr2.push_back( first ) ;
   numbers.pop_front( ) ;
   while ( ! numbers.empty( ) ) {
      first = numbers.front( ) ;
      if ( arr1.back( ) > arr2.back( ) ) {
	 arr1.push_back( first ) ;
      }
      else {
	 arr2.push_back( first ) ;
      }
      numbers.pop_front( ) ;
   }
   for ( int i : arr2 )
      arr1.push_back( i ) ;
   std::cout << "( " ;
   std::copy( arr1.begin( ) , arr1.end( ) , std::ostream_iterator<int>(
	    std::cout , " " )) ;
   std::cout << ")\n" ;
   return 0 ;
}
