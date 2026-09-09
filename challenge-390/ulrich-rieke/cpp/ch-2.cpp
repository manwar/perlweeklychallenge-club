#include <iostream>
#include <string>
#include <sstream>
#include <algorithm>
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

std::string move_letter( const std::string &word ) {
   std::string changed { word.substr( 1 ) + word.substr( 0 , 1 ) } ;
   return changed ;
}

int main( ) {
   std::cout << "Enter a word consisting of alphabetic characters and an integer!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens { split( line , ' ' ) } ;
   std::string startword { tokens[0] } ;
   int k { std::stoi( tokens[1] ) } ;
   if ( k == 1 ) {
      std::vector<std::string> permus ;
      permus.push_back( move_letter( startword ) ) ;
      while ( std::find( permus.begin( ) , permus.end( ) , startword ) == 
            permus.end( ) ) {
         permus.push_back( move_letter( permus[ permus.size( ) - 1] )) ;
      }
      std::sort( permus.begin( ) , permus.end( ) ) ;
      std::cout << permus[0] << '\n' ;
   }
   else {
      std::vector<char> letters ;
      for ( char c : startword ) {
         letters.push_back( c ) ;
      }
      std::sort( letters.begin( ) , letters.end( ) ) ;
      std::string solution ;
      for ( char c : letters ) {
         solution.push_back( c ) ;
      }
      std::cout << solution << '\n' ;
   }
   return 0 ;
}

