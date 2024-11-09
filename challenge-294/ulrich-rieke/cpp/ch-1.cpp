#include <vector>
#include <algorithm>
#include <string>
#include <sstream>
#include <iostream>

std::vector<std::string> split( const std::string & text , char delim ) {
   std::istringstream istr { text } ;
   std::vector<std::string> tokens ;
   std::string word ;
   while ( std::getline( istr , word , delim ) ) {
      tokens.push_back( word ) ;
   }
   return tokens ;
}

int main( ) {
   std::cout << "Enter some integers separated by blanks!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto numberstrings { split( line , ' ' ) } ;
   std::vector<int> numbers , lengths ;
   for ( auto s : numberstrings ) 
      numbers.push_back( std::stoi( s ) ) ;
   std::sort( numbers.begin( ) , numbers.end( ) ) ;
   int len = numbers.size( ) ;
   int run { 1 } ;
   int i = 1 ;
   while ( i < len ) {
      if ( numbers[i] - numbers[i - 1] == 1 ) {
	 run++ ;
      }
      else {
	 lengths.push_back( run ) ;
	 run = 1 ;
      }
      i++ ;
   }
   lengths.push_back( run ) ;
   int maximum = *std::max_element( lengths.begin( ) , lengths.end( ) ) ;
   if ( maximum == 1 ) 
      std::cout << -1 ;
   else 
      std::cout << maximum ;
   std::cout << '\n' ;
   return 0 ;
}


