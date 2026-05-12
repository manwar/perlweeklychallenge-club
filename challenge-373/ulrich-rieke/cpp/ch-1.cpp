#include <iostream>
#include <sstream>
#include <vector>
#include <string>

std::vector<std::string> split( const std::string & text , const char delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr , word , delimiter ) ) 
      tokens.push_back( word ) ;
   return tokens ;
}

int main( ) {
   std::cout << "Enter some words separated by blanks!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto firstWords { split( line , ' ' ) } ;
   std::cout << "Enter some more words separated by blanks!\n" ;
   std::string secondline ;
   std::getline( std::cin , secondline ) ;
   auto secondWords { split( secondline, ' ' ) } ;
   std::string firstTerm , secondTerm ;
   for ( auto w : firstWords ) {
      firstTerm += w ;
   }
   for ( auto w : secondWords ) 
      secondTerm += w ;
   std::cout << std::boolalpha << ( firstTerm == secondTerm ) << '\n' ;
   return 0 ;
}
