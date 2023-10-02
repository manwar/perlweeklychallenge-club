#include <vector>
#include <iostream>
#include <string>
#include <map>
#include <algorithm>
#include <numeric>
#include <set> 

std::vector<std::string> split( const std::string & startline ,
      const std::string & sep ) {
   std::vector<std::string> separated ;
   std::string::size_type start { 0 } ;
   std::string::size_type pos ;
   do {
      pos = startline.find_first_of( sep , start ) ;
      separated.push_back( startline.substr(start , pos - start )) ;
      start = pos + 1 ;
   } while ( pos != std::string::npos ) ;
   return separated ;
}

int findCombinations( int n ) {
   std::vector<int> numers( n ) ;
   std::iota( numers.begin( ) , numers.end( ) , 1 ) ;
   int numerator = std::accumulate( numers.begin( ) , numers.end( ) , 1 , 
	 std::multiplies<int>( ) ) ;
   std::vector<int> denoms( n - 2 ) ;
   std::iota( denoms.begin( ) , denoms.end( ) , 1 ) ;
   int denominator = std::accumulate( denoms.begin( ) , denoms.end( ) , 1 , 
	 std::multiplies<int>( ) ) ;
   return numerator / ( denominator * 2 ) ;
}

int findPairs( int n ) {
   int result = 0 ;
   if ( n == 0 || n == 1 ) {
      result = 0 ; ;
   }
   if ( n == 2 ) {
      result = 1 ;
   }
   if ( n > 2 ) {
      int c = findCombinations( n ) ;
      result = c ;
   }
   return result ;
}

int main( ) {
   std::cout << "Enter some words, separated by blanks!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   std::vector<std::string> words( split( line , " " ) ) ;
   std::map<std::string , int> lettercombis ;
   for ( auto s : words ) {
      std::set<char> uniques ;
      for ( char c : s ) 
	 uniques.insert( c ) ;
      std::string letters ;
      for ( char c : uniques )
	 letters.push_back( c) ;
      std::sort( letters.begin( ) , letters.end( ) ) ;
      lettercombis[ letters ]++ ;
   }
   int pairs = 0 ;
   for ( auto p : lettercombis ) {
      pairs += findPairs( p.second ) ;
   }
   std::cout << pairs << std::endl ;
   return 0 ;
}
