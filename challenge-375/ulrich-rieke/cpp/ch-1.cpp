#include <iostream>
#include <sstream>
#include <vector>
#include <algorithm>
#include <map>

std::vector<std::string> split( const std::string & text , const char 
      delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr , word , delimiter ) ) 
      tokens.push_back( word ) ;
   return tokens ;
}

int main( ) {
   std::cout << "Enter some strings separated by blanks!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto firsttokens { split( line, ' ' ) } ;
   std::cout << "Enter some more strings separated by blanks!\n" ;
   line.clear( ) ;
   std::getline( std::cin , line ) ;
   auto secondtokens { split( line , ' ' ) } ;
   std::map<std::string , int> firstFrequencies , secondFrequencies ;
   for ( auto w : firsttokens)
      firstFrequencies[w]++ ;
   for ( auto w : secondtokens )
      secondFrequencies[w]++ ;
   int howmany = 0 ;
   for ( auto p : firstFrequencies ) {
      auto found = std::find( secondFrequencies.begin( ) ,
            secondFrequencies.end( ) , p ) ;
      if (found != secondFrequencies.end( ) && found->second == 1 ) 
         howmany++ ;
   }
   std::cout << howmany << '\n' ;
   return 0 ;
}
