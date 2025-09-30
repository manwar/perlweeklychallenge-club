#include <iostream>
#include <sstream>
#include <string>
#include <vector>
#include <algorithm>

std::vector<std::string> split( const std::string & text , char delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr , word , delimiter ) ) 
      tokens.push_back( word ) ;
   return tokens ;
}

int main( ) {
   std::cout << "Enter a string and a letter from that string!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens { split( line , ' ' ) } ;
   auto search_in { tokens[0] } ;
   auto search_for { tokens[1] } ;
   auto pos = search_in.find( search_for ) ;
   auto secondPart = search_in.substr( pos + 1 ) ;
   auto firstPart = search_in.substr( 0 , pos + 1 ) ;
   std::reverse( firstPart.begin( ) , firstPart.end( ) ) ;
   std::string result { firstPart + secondPart } ;
   std::cout << result << '\n' ;
   return 0 ;
}
