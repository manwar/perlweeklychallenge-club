#include <iostream>
#include <string>
#include <vector>
#include <sstream>
#include <algorithm>

std::vector<std::string> split( const std::string & text , const char
      delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr , word , delimiter ) )
      tokens.push_back( word ) ;
   return tokens ;
}

int toNumber( const std::string word ) {
   std::string numberstring ;
   for ( char c : word ) {
      int n = static_cast<int>( c ) - 97 ;
      numberstring.push_back( static_cast<char>( n + 48 ) ) ;
   }
   return std::stoi( numberstring ) ;
}

int main( ) {
   std::cout << "Enter 3 strings consisting of lowercase English letters a " ;
   std::cout << "to i only!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens { split( line , ' ' ) } ;
   std::vector<int> numbers( tokens.size( ) ) ;
   std::transform( tokens.begin( ) , tokens.end( ) , numbers.begin( ) , 
         toNumber ) ;
   std::cout << std::boolalpha << ( numbers[0] + numbers[1] == numbers[2] ) 
      << '\n' ;
   return 0 ;
}
