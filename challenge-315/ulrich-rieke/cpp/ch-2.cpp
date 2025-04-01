#include <string>
#include <sstream>
#include <vector>
#include <algorithm>
#include <map>
#include <iostream>
#include <iterator>

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
   std::cout << "Enter a sentence!\n" ;
   std::string sentence ;
   std::getline( std::cin , sentence ) ;
   std::cout << "Enter a first word!\n" ;
   std::string firstword , secondword ;
   std::getline( std::cin , firstword ) ;
   std::cout << "Enter a second word following the first one!\n" ;
   std::getline( std::cin , secondword ) ;
   auto tokens { split( sentence , ' ' ) } ;
   std::map<std::string , std::vector<int>> wordpositions ;
   int pos = 0 ;
   for ( auto w : tokens ) {
      wordpositions[w].push_back( pos ) ;
      pos++ ;
   }
   std::vector<int> positions { wordpositions.find( secondword)->second } ;
   std::transform( positions.begin( ) , positions.end( ) , positions.begin( ) , 
	 []( int i ){ return i + 1 ; } ) ;
   wordpositions[secondword] = positions ;
   std::vector<std::string> solution ;
   for ( auto w : tokens ) {
      if ( w != secondword ) {
	 auto compareTo = wordpositions.find( secondword)->second ;
	 auto posis = wordpositions.find( w )->second ;
	 if ( std::any_of( posis.begin( ) , posis.end( ), [&compareTo]( int i ) {
		  return std::find( compareTo.begin( ) , compareTo.end( ) , i ) != 
		  compareTo.end( ) ; } ) ) {
	    solution.push_back( w ) ;
	 }
      }
   }
   auto it = std::unique( solution.begin( ) , solution.end( ) ) ;
   std::cout << "( ";
   std::copy( solution.begin( ) , it , std::ostream_iterator<std::string>(
	    std::cout , " " )) ;
   std::cout << ")\n" ;
   return 0 ;
}
