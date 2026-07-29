#include <iostream>
#include <string>
#include <map>
#include <algorithm>
#include <sstream>
#include <vector>

std::string convert( int number , const int base) {
   std::map<int , char> conv_table ;
   for ( int i = 0 ; i < 10 ; i++ ) {
      conv_table[i] = static_cast<char>( i + 48 ) ;
   }
   for ( int i = 10 ; i < 36 ; i++ ) 
      conv_table[i] = static_cast<char>( i + 55 ) ;
   for ( int i = 36 ; i < 64 ; i++ ) 
      conv_table[i] = static_cast<char>( i + 61 ) ;
   conv_table[64] = '+' ;
   conv_table[65] = '/' ;
   std::string converted ;
   while ( number != 0 ) {
      converted.push_back( conv_table[number % base] ) ;
      number /= base ;
   }
   std::reverse( converted.begin( ) , converted.end( ) ) ;
   return converted ;
}

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
   std::cout << "Enter a number and a base!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens { split( line , ' ') } ;
   std::vector<int> numbers ;
   for ( auto w : tokens ) 
      numbers.push_back( std::stoi( w ) ) ;
   std::cout << convert( numbers[0] , numbers[1] ) << '\n' ;
   return 0 ;
}

