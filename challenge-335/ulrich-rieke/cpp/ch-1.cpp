#include <iostream>
#include <vector>
#include <sstream>
#include <string>
#include <algorithm>
#include <numeric>
#include <map>

std::vector<std::string> split( const std::string & text , char delimiter) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr , word , delimiter ))
      tokens.push_back( word ) ;
   return tokens ;
}

std::string findCommonCharacters( const std::string & aWord , 
      const std::string & bWord ) {
   std::string common ;
   for ( auto l : aWord ) {
      if ( bWord.find( l ) != std::string::npos ) {
	 common.push_back( l ) ;
      }
   }
   std::sort( common.begin( ) , common.end( ) ) ;
   auto last = std::unique( common.begin( ) , common.end( ) ) ;
   common.erase( last , common.end( ) ) ;
   return common ;
}

int main( ) {
   std::cout << "Enter some words separated by whitespace!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens { split( line , ' ' ) } ;
   std::map<char , std::vector<int>> letterfrequencies ;
   std::string common { findCommonCharacters( tokens[0] , 
	 tokens[1]) } ;
   for ( int i = 1 ; i < tokens.size( ) ; i++ ) {
      common = findCommonCharacters( common , tokens[i] ) ;
   }
   if ( common.empty( ) ) {
      std::cout << "()\n" ;
   }
   else {
      for ( auto w : tokens ) {
	 std::map<char , int> frequency_in_word ;
	 for ( auto l : w ) {
	    if ( common.find( l ) != std::string::npos ) {
	       frequency_in_word[l]++ ;
	    }
	 }
         for ( auto it = frequency_in_word.begin( ) ; it != 
	       frequency_in_word.end( ) ; ++it ) {
	    letterfrequencies[it->first].push_back( it->second ) ;
	 }
      }
      std::vector<char> result ;
      std::sort( common.begin( ) , common.end( ) ) ;
      for ( char l : common ) {
	 auto foundFrequencies = letterfrequencies.find( l )->second ;
	 int howmany = *std::min_element( foundFrequencies.begin( ) , 
	       foundFrequencies.end( ) ) ;
	 for ( int i = 0 ; i < howmany ; i++ ) {
	    result.push_back( l ) ;
	 }
      }
      std::cout << "( " ;
      for ( char l : result ) {
	 std::cout << l << ' ' ;
      }
      std::cout << ")\n" ;
   }
   return 0 ;
}
