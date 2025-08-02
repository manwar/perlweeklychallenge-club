#include <iostream>
#include <string>
#include <sstream>
#include <algorithm>
#include <vector>
#include <iterator>

std::vector<std::string> split( std::string text , const char delimiter ) {
   std::istringstream istr { text } ;
   std::vector<std::string> tokens ;
   std::string word ;
   while ( std::getline( istr , word , delimiter )) 
      tokens.push_back( word ) ;
   return tokens ;
}

int main( ) {
   std::cout << "Enter some routes, separated by comma!\n" ;
   std::cout << "For every route, separate start and destination by blank!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   std::vector<std::string> routes { split( line, ',' ) } ;
   std::vector<std::vector<std::string>> allRoutes ;
   std::vector<std::string> starts ;//for all start fields
   for ( auto route : routes ) {
      auto routepair = split( route , ' ' ) ;//first vector is start , then end
      allRoutes.push_back( routepair ) ;
      starts.push_back( routepair[0] ) ;//append start to collection of starts
   }
   std::vector<std::string> solution ;
   for ( auto p : allRoutes ) {
      if ( std::find( starts.begin( ) , starts.end( ) , p[1] ) ==
	    starts.end( ) ) //destination not found in starts
	 solution.push_back( p[1] ) ;//so part of solutin
      }
   std::copy( solution.begin( ) , solution.end( ) ,
	 std::ostream_iterator<std::string>( std::cout , " " ) ) ;
   std::cout << '\n' ;
   return 0 ;
}
