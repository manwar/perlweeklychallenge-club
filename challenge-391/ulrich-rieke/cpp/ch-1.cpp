#include <iostream>
#include <vector>
#include <string>
#include <algorithm>
#include <sstream>

std::vector<std::string> split ( const std::string & text , const char
      delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr , word , delimiter ) ) 
      tokens.push_back( word ) ;
   return tokens ;
}

int main( ) {
   std::cout << "Enter a sorted array of integers!\n" ;
   std::string firstline , secondline ;
   std::getline( std::cin , firstline ) ;
   auto firsttokens { split( firstline , ' ' ) } ;
   std::cout << "Enter another sorted array!\n" ;
   std::getline( std::cin , secondline ) ;
   auto secondtokens { split( secondline, ' ' ) } ;
   std::vector<int> firstarray, secondarray ;
   for ( auto s : firsttokens )
      firstarray.push_back( std::stoi( s ) ) ;
   for ( auto s : secondtokens ) 
      secondarray.push_back( std::stoi( s ) ) ;
   //both arrays are sorted , so we can use algorithm merge to get a
   //sorted target array
   std::vector<int> targetarray ( firstarray.size( ) +
         secondarray.size( ) ) ;
   std::merge( firstarray.begin( ) , firstarray.end( ) , secondarray.
         begin( ) , secondarray.end( ) , targetarray.begin( ) ) ;
   int l = static_cast<int>( targetarray.size( ) ) ;
   if ( l % 2 == 1 ) {
      std::cout << targetarray[l / 2 ] << '\n' ;
   }
   else {
      std::cout << ( targetarray[l / 2 - 1] + targetarray[l / 2]) / 2.0 
         << '\n' ;
   }
   return 0 ;
}
      
