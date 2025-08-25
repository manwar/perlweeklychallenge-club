#include <vector>
#include <string>
#include <sstream>
#include <regex>
#include <iostream>
#include <numeric>
#include <algorithm>

std::vector<std::string> split( const std::string & text , char delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr , word , delimiter ) ) 
      tokens.push_back( word ) ;
   return tokens ;
}

int main( ) {
   std::cout << "Enter some numbers and D , C or + separated by whitespace!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens { split( line , ' ' ) } ;
   std::vector<int> numbers ;
   std::string numpattern {"(\\-)*\\d+"} ;
   std::regex nu { numpattern } ;
   auto until = std::find_if( tokens.begin( ) , tokens.end( ) , [nu]( const auto w )
	 { return ! std::regex_match( w.begin( ) , w.end( ) , nu ) ; } ) ;
   for ( auto it = tokens.begin( ) ; it != until ; ++it ) 
      numbers.push_back( std::stoi( *it ) ) ;
   for ( auto it = until ; it != tokens.end( ) ; ++it ) {
      if ( ! std::regex_match( *it , nu ) ) { // no number ! 
	 if ( *it == "C" ) {
	    numbers.pop_back( ) ;
	 }
	 if ( *it == "D" ) {
	    int last = numbers.back( ) ;
	    numbers.push_back( last * 2 ) ;
	 }
	 if ( *it == "+" ) {
	    int l = numbers.size( ) ;
	    numbers.push_back( numbers[l - 2] + numbers[l - 1] ) ;
	 }
      }
      else { // it's a number !
	 numbers.push_back( std::stoi( *it ) ) ;
      }
   }
   std::cout << std::accumulate( numbers.begin( ) , numbers.end( ) , 0 ) << '\n' ;
   return 0 ;
}
