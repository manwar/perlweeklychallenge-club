#include <iostream>
#include <vector>
#include <sstream>
#include <string>
#include <algorithm>

std::vector<std::string> split( const std::string & text , char delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr , word , delimiter ) ) 
      tokens.push_back( word ) ;
   return tokens ;
}

std::string to_binary_string( int part ) {
   std::string binary ;
   while ( part != 0 ) {
      if ( part % 2 == 1 ) {
	 binary.push_back( '1' ) ;
      }
      else {
	 binary.push_back( '0' ) ;
      }
      part /= 2 ;
   }
   std::reverse( binary.begin( ) , binary.end( )) ;
   return binary ;
}

int main( ) {
   std::cout << "Enter a date as year-month-day!\n" ;
   std::string date ;
   std::getline( std::cin , date ) ;
   auto dateparts { split( date , '-' ) } ;
   std::vector<std::string> transformed ;
   for ( auto part : dateparts ) {
      int numdate = std::stoi( part ) ;
      transformed.push_back( to_binary_string( numdate ) ) ;
   }
   std::string solution ;
   for ( auto s : transformed ) {
      solution += s ;
      solution.push_back( '-' ) ;
   }
   solution.pop_back( ) ;
   std::cout << solution << '\n' ;
   return 0 ;
}
