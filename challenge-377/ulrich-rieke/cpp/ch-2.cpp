#include <iostream>
#include <string>
#include <sstream>
#include <vector>

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
   auto words { split( line, ' ' ) } ;
   int result = 0 ;
   int len = words.size( ) ;
   for ( int i = 0 ; i < len - 1 ; i++ ) {
      for ( int j = i + 1 ; j < len ; j++ ) {
         std::string first { words[i] } ;
         std::string second { words[ j ] } ;
         int fl = static_cast<int>( first.length( ) ) ;
         int sl = static_cast<int>( second.length( ) ) ;
         if ( fl <= sl ) {
            if ( second.substr( 0 , fl )  == first && 
                  second.substr( sl - fl ) == first ) {
               result++ ;
            }
         }
      }
   }
   std::cout << result << '\n' ;
   return 0 ;
}


