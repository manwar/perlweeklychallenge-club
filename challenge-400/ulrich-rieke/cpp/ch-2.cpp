#include <iostream>
#include <sstream>
#include <string>
#include <vector>
#include <algorithm>
#include <numeric>

std::vector<std::string> split( const std::string & text , const 
      char delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr , word , delimiter ) ) 
      tokens.push_back( word ) ;
   return tokens ;
}

int string_difference( const std::string & wordA , const std::string &
      wordB ) {
   int mutations { 0 } ;
   //both words are known to be of equal length
   int len { static_cast<int>(wordA.length( ) ) } ;
   for ( int i = 0 ; i < len ; i++ ) {
      if ( wordA.substr( i , 1 ) != wordB.substr( i , 1 ) ) 
         mutations++ ;
   }
   return mutations ;
}

int main( ) {
   std::cout << "Enter a start genome!\n" ;
   std::string start , end ;
   std::getline( std::cin , start ) ;
   std::cout << "Enter an end genome of equal length!\n" ;
   std::getline( std::cin , end ) ;
   std::cout << "Enter some genes of equal length!\n" ;
   std::string bank ;
   std::getline( std::cin , bank ) ;
   auto genes { split( bank , ' ' ) } ;
   if ( start == end ) {
      std::cout << 0 << '\n' ;
   }
   else {
      if ( std::find( genes.begin( ) , genes.end( ) , end ) == genes.end( ) ) {
         std::cout << -1 << '\n' ;
      }
      else {
         std::vector<int> mutation_numbers ;
         for ( auto s : genes ) {
            mutation_numbers.push_back( string_difference( s , start ) ) ;
         }
         int mutations { string_difference( start , end ) } ;
         std::vector<int> comparison( mutations ) ;
         std::iota( comparison.begin( ) , comparison.end( ) , 1 ) ;
         if ( std::all_of( comparison.begin( ) , comparison.end( ),
                  [mutation_numbers]( const int n ) { return std::find( 
                     mutation_numbers.begin( ) , mutation_numbers.end( )
                     , n ) != mutation_numbers.end( ) ; } ) ) {
            std::cout << mutations << '\n' ;
         }
         else {
            std::cout << -1 << '\n' ;
         }
      }
   }
   return 0 ;
}
