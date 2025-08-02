#include <vector>
#include <string>
#include <sstream>
#include <iostream>

std::vector<std::string> split( const std::string & text , char delimiter ) {
   std::vector<std::string> tokens ;
   std::string word ;
   std::istringstream istr { text } ;
   while ( std::getline( istr , word , delimiter ))
      tokens.push_back( word ) ;
   return tokens ;
}

int main( ) {
   std::cout << "Enter an even amount of positive integers separated by blanks!\n";
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens { split( line , ' ' ) } ;
   std::vector<int> numbers ;
   for ( auto s : tokens ) 
      numbers.push_back(std::stoi( s ) ) ;
   std::vector<int> solution ;
   int len = numbers.size( ) ;
   int pos = 0 ;
   while ( pos < len - 1 ) {
      int howmany = numbers[pos] ;
      for ( int i = 0 ; i < howmany ; i++ ) 
	 solution.push_back( numbers[pos + 1] ) ;
      pos += 2 ;
   }
   std::cout << "( " ;
   for ( int i : solution ) {
      std::cout << i << ' ' ;
   }
   std::cout << ")\n" ;
   return 0 ;
}
