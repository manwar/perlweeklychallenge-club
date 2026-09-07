#include <iostream>
#include <vector>
#include <sstream>
#include <utility>
#include <cctype>
#include <algorithm>
using namespace std::string_literals ;

std::vector<std::string> split( const std::string & text , const char 
      delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr , word , delimiter ) ) 
      tokens.push_back( word ) ;
   return tokens ;
}

std::string toUpper( const std::string & word ) {
   std::string upcase ;
   for ( char c : word ) {
      upcase.push_back( std::toupper( c ) ) ;
   }
   return upcase ;
}

int main( ) {
   std::cout << "Enter a composer name!\n" ;
   std::string composer ;
   std::getline( std::cin , composer ) ;
   std::cout << "Enter some notes!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto notes { split( line , ' ' ) } ;
   std::cout << "Enter permutations , as many as there are notes!\n" ;
   std::string permuline ;
   std::getline( std::cin , permuline ) ;
   auto tokens { split( permuline , ' ' ) } ;
   std::vector<int> permus ;
   for ( auto s : tokens ) 
      permus.push_back( std::stoi( s ) ) ;
   std::string output { toUpper( composer ) } ;
   output += " => "s ;
   std::vector<std::pair<int , std::string>> combinations ;
   for ( int i = 0 ; i < permus.size( ) ; i++ ) {
      combinations.push_back( std::make_pair( permus[i] , notes[i] )) ;
   }
   std::sort( combinations.begin( ) , combinations.end( ) , []( const auto p1 , 
            const auto p2 ) {return p1.first < p2.first ; } ) ;
   for ( int i = 0 ; i < combinations.size( ) ; i++ ) {
      output += ( combinations[i].second + " " ) ;
   }
   std::cout << output << '\n' ;
   return 0 ;
}
