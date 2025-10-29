#include <vector>
#include <sstream>
#include <string>
#include <iostream>

std::vector<std::string> split( const std::string & text , const char 
      delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr , word , delimiter ) ) 
      tokens.push_back( word ) ;
   return tokens ;
}

int main( ) {
   std::cout << "Enter at least 3 integers separated by blanks!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens { split( line , ' ' ) } ;
   std::vector<int> numbers ;
   for ( auto s : tokens ) 
      numbers.push_back( std::stoi( s ) ) ;
   std::vector<int> indices ;
   for ( int i = 1 ; i < static_cast<int>(numbers.size( )) - 1 ; i++ ) {
      if ( numbers[i] > numbers[i - 1] && numbers[i] > numbers[i + 1] ) {
	 indices.push_back( i ) ;
      }
   }
   std::cout << "( " ;
   for ( int i : indices ) 
      std::cout << i << ' ' ;
   std::cout << ")\n" ;
   return 0 ;
}
