#include <vector>
#include <iostream>
#include <sstream>
#include <algorithm>
#include <numeric>
#include <string>

std::vector<std::string> split( const std::string & text , 
      const char delimiter ) {
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
   std::adjacent_difference( numbers.begin( ) , numbers.end( ) , 
         numbers.begin( ) ) ;
   if ( std::any_of( numbers.begin( ) + 1 , numbers.end( ) , []( const int
               n ) { return n == 0 ; } ) ) {
      std::cout << "false\n" ;
   }
   else {
      std::vector<int> firstPart , secondPart , thirdPart ;
      int pos {1} ;
      int l { static_cast<int>( numbers.size( ) ) } ;
      while ( ( pos < l ) && numbers[pos] > 0 ) {
         firstPart.push_back( numbers[pos] ) ;
         pos++ ;
      }
      while ( (pos < l ) && numbers[pos] < 0 ) {
         secondPart.push_back( numbers[pos] ) ;
         pos++ ;
      }
      while ( (pos < l) && numbers[pos] > 0 ) {
         thirdPart.push_back( numbers[pos] ) ;
         pos++ ;
      }
      //for the final boolean we must not forget that std::adjacent_difference
      //adds the first element of the array unchanged into differences
      std::cout << std::boolalpha << ( (firstPart.size( ) + secondPart.size( )
            + thirdPart.size( ) == l - 1 ) && ( firstPart.size( ) > 0 && 
            secondPart.size( ) > 0 && thirdPart.size( ) > 0 )) << '\n' ;
  }
  return 0 ;
}
