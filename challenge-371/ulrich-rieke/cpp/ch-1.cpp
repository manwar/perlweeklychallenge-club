#include <string> 
#include <iostream>
#include <vector>
#include <set>
#include <algorithm>
#include <iterator>


char find_missing( const std::vector<char> & input ) {
   std::vector<int> diffs ;
   int len = input.size( ) ;
   for ( int i = 1 ; i < len ; i++ ) {
      if ( input[ i ] != '?' && input[i - 1] != '?' ) {
         diffs.push_back( static_cast<int>( input[i] ) - static_cast<int>(
                  input[ i - 1] ) ) ;
      }
   }
   auto found = std::find( input.begin( ) , input.end( ) , '?' ) ;
   int question_pos = static_cast<int>(std::distance( input.begin( ) , found )) ;
   std::set<int> uniques { diffs.begin( ) , diffs.end( ) } ;
   if ( uniques.size( ) == 1 ) { //only one difference 
      if ( question_pos == 0 ) {
         return static_cast<char>( static_cast<int>( input[1] ) - diffs[0] ) ;
      }
      else {
         return static_cast<char>( static_cast<int>( input[ question_pos - 1] ) +
               diffs[0] ) ;
      }
   }
   else { //two differences
      std::vector<int> newdiffs ;
      //create alternating diffs
      for ( int i = 0 ; i < 2 ; i++ ) {
         newdiffs.push_back( diffs[0] ) ;
         newdiffs.push_back( diffs[1] ) ;
      }
      if ( question_pos == 0 ) {
         return static_cast<char>( static_cast<int>(input[1] ) - newdiffs[0] ) ;
      }
      else {
         return static_cast<char>( static_cast<int>( input[question_pos - 1]) +
                  newdiffs[question_pos - 1] ) ;
      }
   }
}

int main( ) {
   std::vector<char> example1 { 'a' , 'c' , '?' , 'g' , 'i' } ;
   std::vector<char> example2 { 'a' , 'd' , '?' , 'j' , 'm' } ;
   std::vector<char> example3 { 'a' , 'e' , '?' , 'm' , 'q' } ;
   std::vector<char> example4 { 'a' , 'c' , 'f' , '?' , 'k' } ;
   std::vector<char> example5 { 'b' , 'e' , 'g' , '?' , 'l' } ;
   std::cout << find_missing( example1 ) << '\n' ;
   std::cout << find_missing( example2 ) << '\n' ;
   std::cout << find_missing( example3 ) << '\n' ;
   std::cout << find_missing( example4 ) << '\n' ;
   std::cout << find_missing( example5 ) << '\n' ;
   return 0 ;
}

