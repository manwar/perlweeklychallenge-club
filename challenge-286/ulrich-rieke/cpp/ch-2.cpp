#include <iostream>
#include <vector>
#include <sstream>
#include <utility>
#include <numeric>

//routine for splitting a string at a given delimiter
std::vector<std::string> split( const std::string & text , const char 
      delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr, word , delimiter )) {
      tokens.push_back( word ) ;
   }
   return tokens ;
}

int main( ) {
   std::cout << "Enter 2 ^ n integers, where n is a positive integer!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens = split( line , ' ' ) ;
   std::vector<int> numbers ;
   for ( auto s : tokens ) 
      numbers.push_back( std::stoi( s ) ) ;
   bool last_was_min = false ;//did we determine the minimum last time ?
   while ( numbers.size( ) > 1 ) {
      std::vector<std::pair<int , int>> allPairs ;// all neighbouring pairs
      for ( int i = 0 ; i < numbers.size( ) - 1 ; i += 2 ) {
	 allPairs.push_back( std::make_pair( numbers[i] , numbers[i + 1] )) ;
      }
      std::vector<int> intermediate ; //for the minima and maxima
      for ( auto it = allPairs.begin( ) ; it != allPairs.end( ) ; it++ ) {
	 if ( last_was_min ) {
	    intermediate.push_back( std::max( it->first , it->second ) ) ;
	    last_was_min = false ; //toggle the boolean value 
	 }
	 else {
	    intermediate.push_back( std::min( it->first , it->second ) ) ;
	    last_was_min = true ;
	 }
      }
      numbers = intermediate ;
      intermediate.clear( ) ;
   }
   std::cout << *numbers.begin( ) << '\n' ;
   return 0 ;
}
