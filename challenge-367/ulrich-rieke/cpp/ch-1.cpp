#include <iostream>
#include <string>
#include <algorithm> 

std::string rearrange( const std::string & binary ) {
   std::string output ;
   int len = static_cast<int>( binary.length( ) ) ;
   int ones = std::count( binary.begin( ) , binary.end( ) , '1' ) ;
   output.push_back( '1' ) ;
   int zeroes = len - ones ;
   output.insert( 0 , zeroes , '0' ) ;
   int remaining_ones = ones - 1 ;
   output.insert( 0 , remaining_ones , '1' ) ;
   return output ;
}

int main( ) {
   std::cout << "Enter a binary string with at least one 1!\n" ;
   std::string binary ;
   std::cin >> binary ;
   std::cout << rearrange( binary ) << '\n' ;
   return 0 ;
}

