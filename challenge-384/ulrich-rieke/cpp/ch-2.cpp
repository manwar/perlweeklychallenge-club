#include <iostream>
#include <string>
#include <vector>
#include <algorithm>

bool condition( const std::string & word ) {
   int l = static_cast<int>( word.length( ) ) ;
   int half = l / 2 ;
   std::string firsthalf , secondhalf ;
   for ( int i = 0 ; i < half ; ++i ) {
      firsthalf.push_back( '0' ) ;
      secondhalf.push_back( '1' ) ;
   }
   return (word.substr(0 , half ) == firsthalf && word.substr( half ) == 
      secondhalf) || ( word.substr( 0 , half ) == secondhalf && 
         word.substr( half ) == firsthalf ) ;
}

int main( ) {
   std::cout << "Enter a binary string consisting of 0 and 1 only!\n" ;
   std::string binary ;
   std::cin >> binary ;
   if ( std::all_of( binary.begin( ) , binary.end( ) , []( char c ) {
            return c == '0' ; } ) || std::all_of( binary.begin( ) , 
               binary.end( ) , []( char c ) { return c == '1' ; } )) {
      std::cout << "()\n" ;
   }
   else {
      int l = static_cast<int>( binary.length( ) ) ;
      std::vector<std::string> solution ;
      //from every position in the word go as far to the right as
      //necessary to fulfil the condition above . If there is one enter
      //it in the solution array 
      for ( int pos = 0 ; pos < l - 1 ; pos++ ) {
         for ( int len = 2 ; len < l - pos + 1 ; len++ ) {
            std::string found { binary.substr( pos , len ) } ;
            if ( condition( found ) ) {
               solution.push_back( found ) ;
               break ;
            }
         }
      }
      std::cout << "( " ;
      for ( auto w : solution ) {
         std::cout << w << ' ' ;
      }
      std::cout << ")\n" ;
   }
   return 0 ;
}

