#include <iostream>
#include <string>
#include <map>
#include <vector> 
#include <algorithm>

bool isAscending( const std::vector<int> & numbers ) {
   int len = numbers.size( ) ;
   for ( int i = 0 ; i < len - 1 ; i++ ) {
      if ( numbers[i + 1] - numbers[i] != 1 ) 
	 return false ;
   }
   return true ;
}

int main( ) {
   std::cout << "Enter a word!\n" ;
   std::string word ;
   std::cin >> word ;
   std::map<char , std::vector<int>> positions ;
   for ( int i = 0 ; i < word.length( ) ; i++ ) {
      positions[word[i]].push_back( i ) ;
   }
   std::vector<std::string> solution ;
   for ( int i = 0 ; i < word.length( ) ; i++ ) {
      auto it = positions.find( word[i] ) ;
      int len = (it->second).size( ) ;
      if ( len >= 3 && isAscending( it->second )) {
	 std::string current ;
	 for ( int i = 0 ; i < len ; i++ ) 
	    current.push_back( it->first ) ;
	 if ( std::find( solution.begin( ) , solution.end( ) , current ) ==
	       solution.end( ) ) {
	    solution.push_back( current ) ;
	 }
      }
   }
   if ( solution.size( ) > 0 ) {
      for ( auto s : solution ) 
	 std::cout << s << ' ' ;
      std::cout << '\n' ;
   }
   else {
      std::cout << "\"\"" ;
      std::cout << '\n' ;
   }
   return 0 ;
}
