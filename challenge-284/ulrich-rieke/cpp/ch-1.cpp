#include <vector>
#include <iostream>
#include <sstream>
#include <numeric>
#include <algorithm>
#include <string>

std::vector<std::string> split( std::string text , const char delimiter ) {
   std::stringstream instr { text } ;
   std::vector<std::string> tokens ;
   std::string word ;
   while ( std::getline( instr, word , delimiter ) ) 
      tokens.push_back( word ) ;
   return tokens ;
}

int main( ) {
   std::cout << "Enter some integers, separated by blanks!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto numberline { split( line , ' ' ) } ;
   std::vector<int> numbers ;
   for ( auto s : numberline ) 
      numbers.push_back( std::stoi( s ) ) ;
   std::vector<int> selected ;
   for ( int i : numbers ) {
      if ( std::count( numbers.begin( ) , numbers.end( ) , i ) == i ) 
	 selected.push_back( i ) ;
   }
   int len = selected.size( ) ;
   if ( len > 1 ) {
      std::cout << *std::max_element( selected.begin( ) , selected.end( ) ) <<
	 '\n' ;
   }
   else if ( len == 1 ) {
      std::cout << selected[0] << '\n' ;
   }
   else {
      std::cout << -1 << '\n' ;
   }
   return 0 ;
}

