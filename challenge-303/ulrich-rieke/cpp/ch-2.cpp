#include <string>
#include <iostream>
#include <vector>
#include <sstream>
#include <algorithm>
#include <cstdlib>
#include <numeric>

std::vector<std::string> split( const std::string & text , char delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr , word , delimiter ) ) {
      tokens.push_back( word ) ;
   }
   return tokens ;
}

std::vector<std::vector<int>> createSublists( const std::vector<int> &
      list ) {
   std::vector<std::vector<int>> allSublists ;
   std::vector<int> currentList ;
   currentList.push_back( list[0] ) ;
   int len = list.size( ) ;
   for ( int i = 1 ; i < len ; i++ ) {
      if ( std::abs( currentList[0] - list[i] ) == 1 ) {
	 currentList.push_back( list[i] ) ;
      }
      else {
	 allSublists.push_back( currentList ) ;
	 currentList.clear( ) ;
	 currentList.push_back( list[i] ) ;
      }
   }
   if ( currentList.size( ) > 0 ) 
      allSublists.push_back( currentList ) ;
   return allSublists ;
}

int findSum( const std::vector<std::vector<int>> & sublists ) {
   int sum = 0 ;
   for ( auto vec : sublists ) 
      sum += vec[0] ;
   return sum ;
}

int main( ) {
   std::cout << "Enter some integers separated by whitespace!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens { split( line , ' ' ) } ;
   std::vector<int> numbers ;
   for ( auto s : tokens ) 
      numbers.push_back( std::stoi( s ) ) ;
   std::vector<int> allSums ;
   std::sort( numbers.begin( ) , numbers.end( ) ) ;
   auto sublists { createSublists( numbers ) } ;
   allSums.push_back( findSum( sublists ) ) ;
   while ( std::next_permutation( numbers.begin( ) , numbers.end( ) )) {
      auto currentSublist { createSublists( numbers ) } ;
      auto sum = findSum( currentSublist ) ;
      allSums.push_back( sum ) ;
   }
   std::cout << *std::max_element( allSums.begin( ) , allSums.end( ) ) <<
      '\n' ;
   return 0 ;
}
