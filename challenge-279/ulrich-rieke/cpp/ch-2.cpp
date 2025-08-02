#include <string>
#include <algorithm>
#include <iostream>

int main( ) {
   std::cout << "Enter a string!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   std::string vowels {"aeiouAEIOU"} ;
   std::cout << std::boolalpha << (std::count_if( line.begin( ) , line.end( ),
	 [vowels]( char c ) { return vowels.find( c ) != std::string::npos ; 
	 } ) % 2 == 0 ) << '\n' ;
   return 0 ;
}
