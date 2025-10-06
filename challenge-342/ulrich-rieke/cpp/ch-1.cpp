#include <iostream>
#include <string>
#include <algorithm>
#include <vector>
#include <cctype>
#include <cstdlib>

int main( ) {
   std::cout << "Enter a word with lowercase English letters and digits only!\n" ;
   std::string word ;
   std::cin >> word ;
   std::vector<char> letters , digits ;
   for ( char c : word ) {
      if ( std::isdigit( c ) ) 
	 digits.push_back( c ) ;
      else 
	 letters.push_back( c ) ;
   }
   int lettercount = static_cast<int>( letters.size( ) ) ;
   int digitcount = static_cast<int>( digits.size( ) ) ;
   if ( std::abs( lettercount - digitcount ) > 1 ) {
      std::cout << "\"\"\n" ;
   }
   else {
      std::sort( letters.begin( ) , letters.end( ) ) ;
      std::sort( digits.begin( ) , digits.end( ) ) ;
      std::string solution ;
      if ( digitcount >= lettercount ) {
	 while ( digits.size( ) > 0 ) {
	    solution.push_back( *digits.begin( ) ) ;
	    digits.erase( digits.begin( ) ) ;
	    if ( letters.size( ) > 0 ) {
	       solution.push_back( *letters.begin( ) ) ;
	       letters.erase( letters.begin( ) ) ;
	    }
	 }
      }
      else {
	 while ( letters.size( ) > 0 ) {
	    solution.push_back( *letters.begin( ) ) ;
	    letters.erase( letters.begin( ) ) ;
	    if ( digits.size( ) > 0 ) {
	       solution.push_back( *digits.begin( ) )  ;
	       digits.erase( digits.begin( ) ) ;
	    }
	 }
      }
      std::cout << solution << '\n' ;
   }
   return 0 ;
}
