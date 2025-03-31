#include <vector>
#include <iostream>
#include <sstream>
#include <string>
#include <iterator>
#include <algorithm>

std::vector<std::string> split( const std::string & text , char delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr , word , delimiter ) ) {
      tokens.push_back( word ) ;
   }
   return tokens ;
}

int main( ) {
   std::cout << "Enter a sentence!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   char d ;
   std::cout << "Enter a character!\n" ;
   std::cin >> d ;
   auto tokens { split( line , ' ' ) } ;
   std::vector<int> result ;
   int pos = 0 ;
   for ( auto s : tokens ) {
      if ( s.find_first_of( d ) != std::string::npos ) {
	 result.push_back( pos ) ;
      }
      pos++ ;
   }
   std::cout << "( " ;
   std::copy( result.begin( ) , result.end( ) , std::ostream_iterator<int>( std::cout ,
	    " " )) ;
   std::cout << ")\n" ;
   return 0 ;
}

