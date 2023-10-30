#include <iostream>
#include <vector>
#include <numeric>
#include <set>
#include <algorithm>

//my assumption is that you can always find a loop if the starting array 
//is a random shuffle of all the indices of a vector from 0 to len - 1 where
//len is the length of the array. 

int main( ) {
   std::vector<int> numbers( 20 ) ;
   std::iota( numbers.begin( ) , numbers.end( ) , 1 ) ;
   std::random_shuffle( numbers.begin( ) , numbers.end( ) ) ;
   int loops = 0 ;
   for ( int pos = 0 ; pos < 20 ; pos++ ) {
      if ( numbers[ pos ] == pos ) { 
	 loops++ ;
      }
      else {
	 std::set<int> already_seen ;
	 int num = numbers[ pos ] ;
	 auto p = already_seen.insert( num ) ;
	 while ( p.second ) {
	    if ( already_seen.find( num ) != already_seen.end( ) ) {
	       loops++ ;
	       break ;
	    }
	    else {
	       num = numbers[ num ] ;
	       p = already_seen.insert( num ) ;
	    }
	 }
      }
   }
   std::cout << loops << std::endl ;
   return 0 ;
}
