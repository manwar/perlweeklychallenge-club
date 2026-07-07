#include <string>
#include <iostream>
#include <vector>
#include <sstream>
#include <algorithm>

std::vector<std::string> split( const std::string &text , const char 
      delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr , word , delimiter ) ) 
      tokens.push_back( word ) ;
   return tokens ;
}

int main( ) {
   std::cout << "Enter some integers separated by blanks!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens { split( line , ' ' ) } ;
   std::vector<int> numbers ;
   for ( auto w : tokens ) 
      numbers.push_back( std::stoi( w ) ) ;
   int len = static_cast<int>( numbers.size( ) ) ;
   if ( len < 3 ) {
      std::cout << 0 << '\n' ;
   }
   else {
      std::cout << std::count_if( numbers.begin( ) , numbers.end( ) , 
            [numbers]( const int n ) { return (std::any_of( numbers.begin( ),
               numbers.end( ) , [n]( const int a) { return a < n ; } )) && 
            (std::any_of( numbers.begin( ) , numbers.end( ) , [n] ( const int b )
                          { return b > n ; } ) ) ; } ) << '\n' ;
   }
   return 0 ;
}
