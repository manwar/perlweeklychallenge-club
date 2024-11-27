#include <string>
#include <iostream>
#include <sstream>
#include <utility>
#include <vector>
#include <set>

std::pair<int , int> enterCoordinates( const std::string & text , char
      delimiter ) {
   std::istringstream istr { text } ;
   std::vector<std::string> tokens ;
   std::string word ;
   while ( std::getline( istr , word , delimiter ) ) {
      tokens.push_back( word ) ;
   }
   return std::make_pair( std::stoi( tokens[0] ) , std::stoi(
            tokens[1] ) ) ;
}

bool isSimilar( const std::pair<int , int> & p1 , const std::pair<int, int> &
      p2 ) {
   return ( p1.first == p2.first && p1.second == p2.second ) || 
      ( p1.first == p2.second && p1.second == p2.first ) ;
}

int main( ) {
   std::vector<std::pair<int, int>> dominoes ;
   std::cout << "Enter 2 integers, separated by blanks, for a domino!\n" ;
   std::cout << "Enter <return> to end entry!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   while ( ! line.empty( ) ) {
      auto p { enterCoordinates( line , ' ' ) } ;
      dominoes.push_back( p ) ;
      std::getline( std::cin , line ) ;
   }
   std::set<int> similarIndices ;
   int len = dominoes.size( ) ;
   for ( int i = 0 ; i < len - 1 ; i++ ) {
      for ( int j = i + 1 ; j < len ; j++ ) {
	 if ( isSimilar( dominoes[i] , dominoes[j] ) ) {
	    similarIndices.insert( i ) ;
	    similarIndices.insert( j ) ;
	 }
      }
   }
   std::cout << similarIndices.size( ) << '\n' ;
   return 0 ;
}

