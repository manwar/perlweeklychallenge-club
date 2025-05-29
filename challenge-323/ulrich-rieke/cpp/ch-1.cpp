#include <string>
#include <vector>
#include <iostream>
#include <sstream>

std::vector<std::string> split( const std::string & text , char delimiter ) {
   std::vector<std::string> tokens ;
   std::string word ;
   std::istringstream istr { text } ;
   while ( std::getline( istr , word , delimiter ))
      tokens.push_back( word ) ;
   return tokens ;
}

int main( ) {
   std::cout << "Enter some operations separated by whitespace!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens { split( line, ' ' ) } ;
   int value = 0 ;
   for ( auto op : tokens ) {
      if ( op.find( "++" ) != std::string::npos ) {
	 value++ ;
      }
      if ( op.find( "--" ) != std::string::npos ) {
	 value-- ;
      }
   }
   std::cout << value << '\n' ;
   return 0 ;
}
