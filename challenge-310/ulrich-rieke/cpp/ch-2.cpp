#include <vector>
#include <string>
#include <sstream>
#include <iostream>
#include <algorithm>

std::vector<std::string> split( const std::string & text , char delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr , word , delimiter ) ) {
      tokens.push_back( word ) ;
   }
   return tokens ;
}

int main( ) {
   std::cout << "Enter some integers separated by blanks!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens { split( line , ' ' ) } ;
   std::vector<int> numbers , evens , odds , merged ;
   for ( auto s : tokens ) 
      numbers.push_back( std::stoi( s ) ) ;
   int len = numbers.size( ) ;
   for ( int pos = 0 ; pos < len ; pos++ ) {
      if ( pos % 2 == 0 ) 
	 evens.push_back( numbers[ pos ] ) ;
      else
	 odds.push_back( numbers[ pos ] ) ;
   }
   std::sort( evens.begin( ) , evens.end( )) ;
   std::sort( odds.begin( ) , odds.end( ) , []( int a , int b ) { return a 
	 > b ; } ) ;
   for ( int pos = 0 ; pos < len ; pos++ ) {
      int number = 0 ;
      if ( pos % 2 == 0 ) {
	 number = evens.front( ) ;
	 evens.erase( evens.begin( ) ) ;
      }
      else {
	 number = odds.front( ) ;
	 odds.erase( odds.begin( ) ) ;
      }
      merged.push_back( number ) ;
   }
   std::cout << "( " ;
   for ( int i : merged ) 
      std::cout << i << ' ' ;
   std::cout << ")\n" ;
   return 0 ;
}




