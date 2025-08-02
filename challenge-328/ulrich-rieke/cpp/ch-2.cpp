#include <iostream>
#include <string>
#include <cstdlib>

int main( ) {
   std::cout << "Enter a word with English letters only!\n" ;
   std::string word ;
   std::getline( std::cin , word ) ;
   std::string solution ;
   int len = static_cast<int>(word.length( ) ) ;
   int pos = 0 ;
   while ( pos < len ) {
      solution.push_back( word[pos] ) ;
      int l = static_cast<int>(solution.length( ) ) ;
      if ( l > 1 ) {
	 char first = solution[l - 2] ;
	 char second = solution[l - 1] ;
	 if ( std::abs( static_cast<int>( first ) - static_cast<int>(second ) )
	       == 32 ) {
	    solution = solution.substr( 0 , l - 2 ) ;
	 }
      }
      pos++ ;
   }
   if ( solution.length( ) > 0 ) {
      std::cout << solution ;
   }
   else {
      std::cout << "\"\"" ;
   }
   std::cout << '\n' ;
   return 0 ;
}
