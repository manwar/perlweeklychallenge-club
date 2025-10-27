#include <vector>
#include <string>
#include <iostream>
#include <sstream>
#include <algorithm>

std::vector<std::string> split( const std::string & text , const char
      delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr , word , delimiter ) ) 
      tokens.push_back( word ) ;
   return tokens ;
}

std::vector<std::vector<int>> createSublists( const std::vector<int> & row , 
      const int len ) {
   std::vector<std::vector<int>> sublists ;
   std::vector<int> part ;
   int vlen = static_cast<int>( row.size( ) ) ;
   for ( int start = 0 ; start < vlen - len + 1 ; start++ ) {
      for ( int i = start ; i < start + len ; i++ ) {
	 part.push_back( row[i] ) ;
      }
      sublists.push_back( part ) ;
      part.clear( ) ;
   }
   return sublists ;
}

int main( ) {
   std::cout << "Enter some integers separated by blanks, <return> to end!\n" ;
   std::string line ;
   std::vector<std::vector<int>> source ;
   std::getline( std::cin , line ) ;
   while ( ! line.empty( ) ) {
      auto tokens { split( line , ' ' ) } ;
      std::vector<int> numbers ;
      for ( auto s : tokens ) 
	 numbers.push_back( std::stoi( s ) ) ;
      source.push_back( numbers ) ;
      std::cout << "Enter some integers separated by blanks, <return> to end!\n" ;
      std::getline( std::cin , line ) ;
   }
   std::cout << "Enter some integers separated by blanks!\n" ;
   std::string targetline ;
   std::getline( std::cin , targetline ) ;
   auto numtokens { split( targetline , ' ' ) } ;
   std::vector<int> target ;
   for ( auto s : numtokens ) 
      target.push_back( std::stoi( s ) ) ;
   int totalelements = 0 ;
   for ( auto row : source ) 
      totalelements += static_cast<int>( row.size( ) ) ;
   if ( totalelements != static_cast<int>( target.size( ) )) {
      std::cout << "false\n" ;
   }
   else {
      bool result = std::all_of( source.begin( ) , source.end( ) , [&target](
	       const auto & vec) { auto neighbours = createSublists( target , 
		  static_cast<int>(vec.size( ) ) ) ; return std::find( 
		  neighbours.begin( ) , neighbours.end( ) , vec ) != 
	    neighbours.end( ) ; } ) ;
      std::cout << std::boolalpha << result << '\n' ;
   }
   return 0 ;
}
