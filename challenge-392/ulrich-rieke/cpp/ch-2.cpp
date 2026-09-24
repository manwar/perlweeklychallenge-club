#include <iostream>
#include <vector>
#include <sstream>
#include <string>
#include <algorithm>

std::vector<std::string> split( const std::string & text , const char
      delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr , word , delimiter ) ) 
      tokens.push_back( word ) ;
   return tokens ;
}

bool condition( const std::string & firstword , const std::string &
      secondword ) {
   return std::all_of( firstword.begin( ) , firstword.end( ) , 
         [secondword]( char c ) { return secondword.find( c ) == 
         std::string::npos ; } ) ;
}

int main( ) {
   std::cout << "Enter some strings separated by whitespace!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens { split( line , ' ' ) } ;
   int len { static_cast<int>( tokens.size( ) ) } ;
   int maxi = 0 ;
   for ( int i = 0 ; i < len - 1 ; i++ ) {
      for ( int j = i + 1 ; j < len ; j++ ) {
         if ( condition( tokens[i] , tokens[j] ) ) {
            int value = static_cast<int>( tokens[i].length( ) ) *
               static_cast<int>( tokens[j].length( ) ) ;
            if ( value > maxi ) 
               maxi = value ;
         }
      }
   }
   std::cout << maxi << '\n' ;
   return 0 ;
}

