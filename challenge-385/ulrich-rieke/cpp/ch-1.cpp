#include <iostream>
#include <string>
#include <vector>
#include <sstream>
#include <unordered_map>

std::vector<std::string> split( const std::string &text , const char
      delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr , word , delimiter ))
      tokens.push_back( word ) ;
   return tokens ;
}

int main( ) {
   std::cout << "Enter some strings!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto firstwords { split( line , ' ' ) } ;
   std::cout << "Enter some more strings!\n" ;
   std::getline( std::cin , line ) ;
   auto secondwords { split( line , ' ') } ;
   std::unordered_map<std::string , int> frequencies ;
   for ( auto w : firstwords ) 
      frequencies[w]++ ;
   for ( auto w : secondwords )
      frequencies[w]++ ;
   std::vector<std::string> selected ;
   for ( auto p : frequencies ) {
      if ( p.second == 1 )
         selected.push_back( p.first ) ;
   }
   std::cout << "( " ;
   for ( auto w : selected )
      std::cout << w << ' ' ;
   std::cout << ")\n" ;
   return 0 ;
}
