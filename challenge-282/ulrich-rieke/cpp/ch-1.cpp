#include <iostream>
#include <vector>
#include <algorithm>
#include <string>

int main( ) {
   std::cout << "Enter a long string consisting of digits only!\n" ;
   std::string number ;
   std::cin >> number ;
   std::vector<std::string> triplets , selected ;
   int pos = 0 ;
   while ( pos < number.length( ) - 2 ) {
      triplets.push_back( number.substr( pos , 3 ) ) ;
      pos++ ;
   }
   std::copy_if( triplets.begin( ) , triplets.end( ) ,
	 std::back_inserter( selected ) , []( const auto & s ) {
	 return s.at( 0 ) == s.at( 1 ) && s.at( 1 ) == s.at( 2 ) ; } ) ;
   if ( selected.size( ) == 0 ) 
      std::cout << -1 << '\n' ;
   else
      std::cout << selected[0].substr( 0 , 1 ) << '\n' ;
   return 0 ;
}
   
