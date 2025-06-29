#include <iostream>
#include <string>
#include <sstream>
#include <algorithm>
#include <vector>

std::vector<std::string> split( const std::string & text , char delimiter ) {
   std::vector<std::string> tokens ;
   std::string word ;
   std::istringstream istr { text } ;
   while ( std::getline( istr , word , delimiter ))
      tokens.push_back( word ) ;
   return tokens ;
}

int main( ) {
   std::cout << "Enter some integers separated by blanks!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens { split( line , ' ' ) } ;
   std::vector<int> numbers ;
   for ( auto s : tokens ) 
      numbers.push_back( std::stoi( s ) ) ;
   int len = numbers.size( ) ;
   std::vector<int> solution ;
   for ( int i = 1 ; i < len + 1 ; i++ ) {
      if ( std::find( numbers.begin( ) , numbers.end( ) , i ) == numbers.end( ) )
	 solution.push_back( i ) ;
   }
   std::cout << "( " ;
   for ( int i : solution ) 
      std::cout << i << ' ' ;
   std::cout << ")\n" ;
   return 0 ;
}
