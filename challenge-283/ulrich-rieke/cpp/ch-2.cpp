#include <vector>
#include <sstream>
#include <string>
#include <algorithm>
#include <iostream>
#include <numeric>

std::vector<std::string> split( std::string text , const char delimiter ) {
   std::stringstream instr { text } ;
   std::vector<std::string> allTokens ;
   std::string word ;
   while ( std::getline( instr, word , delimiter ) ) {
      allTokens.push_back( word ) ;
   }
   return allTokens ;
}

int main( ) {
   std::cout << "Enter some positive integers, separated by blanks!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   std::vector<std::string> tokens { split( line, ' ' ) } ;
   std::vector<int> numbers ;
   for ( auto s : tokens ) 
      numbers.push_back( std::stoi( s ) ) ;
   int len = numbers.size( ) ;
   std::vector<int> indices( len ) ;
   std::iota( indices.begin( ) , indices.end( ) , 0 ) ;
   bool result = std::all_of( indices.begin( ) , indices.end( ) , 
	 [&numbers]( int i ) { return std::count( numbers.begin( ) , 
	    numbers.end( ) , i ) == numbers[ i ] ; } ) ;
   std::cout << std::boolalpha << result << '\n' ;
   return 0 ;
}

