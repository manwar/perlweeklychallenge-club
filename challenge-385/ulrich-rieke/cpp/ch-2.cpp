#include <iostream>
#include <string>
#include <utility>
#include <vector>

std::string remove_outermost( const std::string & input ) {
   std::string after_removal ;
   int current { 0 } ;
   std::vector<std::pair<int , char>> letternumbers ;
   for ( char c : input ) {
      if ( c == '(' ) 
         current++ ;
      else 
         current-- ;
      auto p = std::make_pair( current , c ) ;
      letternumbers.push_back( p ) ;
   }
   for ( auto p : letternumbers ) {
      if (p.second == '(' && p.first != 1 ) {
         after_removal.push_back( '(' ) ;
      }
      if ( p.second == ')' && p.first != 0 ) {
         after_removal.push_back( ')' ) ;
      }
   }
   if ( after_removal.length( ) == 0 ) {
      return "\"\"" ;
   }
   else {
      return after_removal ;
   }
}

int main( ) {
   std::cout << remove_outermost( "()()()") << '\n' ;
   std::cout << remove_outermost( "(((())))" ) << '\n' ;
   std::cout << remove_outermost( "(()())(())" ) << '\n' ;
   std::cout << remove_outermost( "()((()))()" ) << '\n' ;
   std::cout << remove_outermost( "(()(()))(()())" ) << '\n' ;
   return 0 ;
}


