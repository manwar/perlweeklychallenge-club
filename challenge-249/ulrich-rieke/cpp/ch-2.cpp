#include <string>
#include <iostream>
#include <algorithm>
#include <vector>
#include <numeric>

bool isValid( const std::vector<int> & permu , const std::vector<int> & the_is , 
      const std::vector<int> & the_ds ) {
   for ( int i = 0 ; i < the_is.size( ) ; i++ ) {
      int pos = the_is[ i ] ;
      if ( permu[pos] >= permu[ pos + 1] ) { 
	 return false ;
      }
   }
   for ( int i = 0 ; i < the_ds.size( ) ; i++ ) { 
      int pos = the_ds[ i ] ;
      if ( permu[pos] <= permu[ pos + 1 ] ) {
	 return false ;
      }
   }
   return true ;
}

int main( ) {
   std::cout << "Please enter a string consisting of capital I and D only!\n" ;
   std::string line ;
   std::cin >> line ;
   std::vector<int> ipositions ;
   std::vector<int> dpositions ;
   for ( int i = 0 ; i < line.length( ) ; i++ ) {
      if ( line.substr( i , 1 ) == "I" ) 
	 ipositions.push_back( i ) ;
      else
	 dpositions.push_back( i ) ;
   }
   int len = line.length( ) ;
   std::vector<int> numbers ( len + 1 ) ;
   std::iota( numbers.begin( ) , numbers.end( ) , 0 ) ;
   std::vector<int> result ;
   if ( dpositions.empty( ) ) {
      result = numbers ;
   }
   else {
      if ( ipositions.empty( ) ) {
	 result = numbers ;
	 std::reverse( result.begin( ) , result.end( ) ) ;
      }
      else {
	 while ( std::next_permutation( numbers.begin( ) , numbers.end( ) ) ) {
	    if ( isValid( numbers, ipositions, dpositions ) ) { 
	       result = numbers ;
	       break ;
	    }
         }
      }
   }
   std::cout << "( " ;
   for ( int i : result ) {
      std::cout << i << " " ;
   }
   std::cout << " )\n" ;
   return 0 ;
}
