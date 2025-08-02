#include <iostream>
#include <string>
#include <vector>
#include <sstream>
#include <utility>
#include <set>
#include <algorithm>

std::vector<std::string> split( const std::string & text , char delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr , word , delimiter ) ) 
      tokens.push_back( word ) ;
   return tokens ;
}

bool isSwapped( const std::pair<std::pair<char , char> , std::pair<char , char>>
      & neighbours ) {
   auto firstPair = neighbours.first ;
   auto secondPair = neighbours.second ;
   return ((firstPair.first == secondPair.second) && firstPair.second == 
      secondPair.first) ;
}

int main( ) {
   std::cout << "Enter two strings separated by space!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens { split( line , ' ' ) } ;
   auto firstWord { tokens[0] } ;
   auto secondWord { tokens[1] } ;
   std::set<char> firstLetters( firstWord.begin( ) , firstWord.end( ) ) ;
   std::set<char> secondLetters( secondWord.begin( ) , secondWord.end( ) ) ;
   if ( firstLetters == secondLetters && firstWord.length( ) == 
	 secondWord.length( ) ) {
      std::vector<std::pair<char , char>> zipped ;
      int len = static_cast<int>( firstWord.length( ) ) ;
      for ( int i = 0 ; i < len ; i++ ) {
	 zipped.push_back( std::make_pair( firstWord[i] , secondWord[i] ) ) ;
      }
      std::vector<std::pair<std::pair<char, char>, std::pair<char, char>>>
	 allNeighbours ;
      for ( int i = 0 ; i < len - 1 ; i++ ) {
	 allNeighbours.push_back(std::make_pair( zipped[i] , zipped[i + 1] )) ;
      }
      if ( std::count_if( allNeighbours.begin( ) , allNeighbours.end( ) , [](
		  const auto & p1 ) { return isSwapped( p1 ) ; } ) == 1 ) {
	 std::cout << "true" ;
      }
      else {
	 std::cout << "false" ;
      }
   }
   else {
      std::cout << "false" ;
   }
   std::cout << '\n' ;
   return 0 ;
}
