#include <vector>
#include <iostream>
#include <algorithm>
#include <string>
#include <map>
#include <cctype>

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

std::map<char, int> findFrequencies( const std::string & word ) {
   std::map<char, int> frequencies ;
   for ( auto it = word.begin( ) ; it != word.end( ) ; it++ ) 
      frequencies[*it]++ ;
   return frequencies ;
}

int main( ) {
   std::cout << "Enter an alphanumeric string!\n" ;
   std::string line , word ;
   std::getline( std::cin , word ) ;
   std::cout << "Enter some alphabetic strings, separated by blanks!\n" ;
   std::getline( std::cin , line ) ;
   std::vector<std::string> strings { split( line , " " ) } ;
   std::string allLower ;
   for ( int i = 0 ; i < word.length( ) ; i++ ) {
      if ( std::isalpha( word[ i ] ) ) {
	 if ( std::isupper( word[i] ) ) 
	    allLower.push_back( tolower( word[i] ) ) ;
	 else 
	    allLower.push_back( word[i] ) ;
      }
   }
   std::map<char , int> letterFreqs ;
   for ( auto it = allLower.begin( ) ; it != allLower.end( ) ; it++ ) 
      letterFreqs[*it]++ ;
   std::vector<std::string> selection ;
   for( auto s : strings ) {
      std::map<char, int> wordFrequencies { findFrequencies( s ) } ;
      if ( std::all_of( letterFreqs.begin( ) , letterFreqs.end( ) , 
	       [wordFrequencies] ( auto p ) { auto found = 
	       wordFrequencies.find( p.first ) ; return ( found != 
		     wordFrequencies.end( ) && found->second >= 
		     p.second ) ; } ) ) 
	 selection.push_back( s ) ;
   }
   if ( selection.size( ) > 0 ) {
      std::sort( selection.begin( ) , selection.end( ) , []( auto a , 
	       auto b ) { return a.length( ) < b.length( ) ; } ) ;
      std::cout << *selection.begin( ) << '\n' ;
   }
   else {
      std::cout << '\n' ;
   }
   return 0 ;
}
