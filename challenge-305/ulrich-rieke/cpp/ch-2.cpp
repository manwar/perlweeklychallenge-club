#include <iostream>
#include <string>
#include <sstream>
#include <algorithm>
#include <vector>
#include <utility>

std::vector<std::string> split( const std::string & text , char delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr , word , delimiter ) ) {
      tokens.push_back( word ) ;
   }
   return tokens ;
}

//translate a word into a word in the ordinary alphabet, that is the position
//of a letter in the given alternative alphabet corresponds to a different one
//in the ordinary one
std::string translate( const std::vector<char> & alphabet , const 
      std::string & word ) {
   std::string translated ;
   for ( auto it = word.begin( ) ; it != word.end( ) ; ++it ) {
      auto pos = std::find( alphabet.begin( ) , alphabet.end( ) , *it ) ;
      int dist = static_cast<int>( std::distance( alphabet.begin( ) , pos ) ) ;
      translated.push_back( static_cast<char>( dist + 97 )) ;
   }
   return translated ;
}

int main( ) {
   std::cout << "Enter some strings separated by whitespace!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto words { split( line , ' ' ) } ;
   std::cout << "Enter a complete alphabet!\n" ;
   std::string alpha ;
   std::getline( std::cin , alpha ) ;
   auto letters { split( alpha , ' ' ) } ;
   std::vector<char> allLetters ;
   for ( auto w : letters ) {
      allLetters.push_back( *w.begin( ) ) ;
   }
   std::vector<std::pair<std::string , std::string>> translated_pairs ;
   for ( auto w : words ) {
      translated_pairs.push_back( std::make_pair( w , translate( allLetters , 
		  w ))) ;
   }
   std::sort( translated_pairs.begin( ) , translated_pairs.end( ) , []( 
	    const auto & p1 , const auto & p2 ) { return p1.second < p2.second 
	 ; } ) ;
   std::cout << '(' ;
   for ( auto p : translated_pairs ) {
      std::cout << p.first << ' ' ;
   }
   std::cout << ")\n" ;
   return 0 ;
}

