#include <string>
#include <sstream>
#include <vector>
#include <iostream>

std::vector<std::string> split( const std::string & text , char delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr , word , delimiter ) ) 
      tokens.push_back( word ) ;
   return tokens ;
}

int main( ) {
   std::cout << "Enter some integers separated by whitespace!\n" ; 
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens { split( line , ' ' ) } ;
   std::vector<int> numbers ;
   for ( auto s : tokens ) 
      numbers.push_back( std::stoi( s ) ) ;
   std::vector<int> afterDoubling ;
   for ( auto it = numbers.begin( ) ; it != numbers.end( ) ; ++it ) {
      if ( *it == 0 ) {
	 afterDoubling.push_back( 0 ) ;
	 afterDoubling.push_back( 0 ) ;
      }
      else 
	 afterDoubling.push_back( *it ) ;
   }
   std::cout << "( " ;
   for ( int i = 0 ; i < numbers.size( ) ; i++ ) {
      std::cout << afterDoubling[i] << ' ' ;
   }
   std::cout << ")\n" ;
   return 0 ;
}

