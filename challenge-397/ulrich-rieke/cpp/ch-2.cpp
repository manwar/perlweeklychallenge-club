#include <iostream>
#include <string>
#include <vector>
#include <sstream>
#include <algorithm>
#include <cmath>

std::vector<std::string> split( const std::string & text , const char
      delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr , word , delimiter ))
      tokens.push_back( word ) ;
   return tokens ;
}

std::vector<int> toReversedBinary( int number ) {
   std::vector<int> binaries ;
   while ( number != 0 ) {
      binaries.push_back( number % 2 ) ;
      number /= 2 ;
   }
   return binaries ;
}

int toNumber( const std::vector<int> & binaries ) {
   int total { 0 } ;
   int len { static_cast<int>( binaries.size( ) ) } ;
   int multiplier { static_cast<int>( std::pow( 2.0 , 
            static_cast<double>( len - 1 ) )) } ;
   for ( int i : binaries ) {
      total += i * multiplier ;
      multiplier /= 2 ;
   }
   return total ;
}

int convert( int number ) {
   auto reversedBinary = toReversedBinary( number ) ;
   int reflected { toNumber( reversedBinary ) } ;
   return reflected ;
}

int main( ) {
   std::cout << "Enter some numbers separated by blanks!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens { split( line , ' ' ) } ;
   std::vector<int> numbers ;
   for ( auto s : tokens )
      numbers.push_back( std::stoi( s ) ) ;
   std::sort( numbers.begin( ) , numbers.end( ) , []( int a , int b) {
         if ( convert( a ) != convert( b )) {
           return convert(a ) < convert( b ) ;
         }
         else {
            return a < b ;
            }
            }) ;
   std::cout << "( " ;
   for ( int i : numbers ) 
      std::cout << i << ' ' ;
   std::cout << ")\n" ;
   return 0 ;
}
