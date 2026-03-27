#include <string>
#include <sstream>
#include <iostream>
#include <vector>
#include <algorithm>

std::vector<std::string> split( const std::string & text , const char delimiter) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr , word , delimiter ) )
      tokens.push_back( word ) ;
   return tokens ;
}

int main( ) {
   std::cout << "Enter a sentence with some words!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens { split( line , ' ' ) } ;
   std::cout << "Enter a word!\n" ;
   std::string word ;
   std::cin >> word ;
   std::cout << std::count_if( tokens.begin( ) , tokens.end( ) , [word]( const 
            auto s ) { return word.starts_with( s ) ; } ) << '\n' ;
   return 0 ;
}
