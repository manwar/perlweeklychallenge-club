#include <iostream>
#include <string>
#include <algorithm>
#include <map>

int main( ) {
   std::cout << "Enter a word!\n" ;
   std::string word ;
   std::getline( std::cin , word ) ;
   std::map<char , int> frequencies ;
   for ( char c : word ) 
      frequencies[c]++ ;
   std::cout << std::boolalpha << std::all_of( frequencies.begin( ) , 
	 frequencies.end( ) , []( const auto & p ) { return p.second % 2 == 
	 1 ; } ) << '\n' ;
   return 0 ;
}
