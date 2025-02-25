#include <vector>
#include <iostream>
#include <algorithm>
#include <sstream>
#include <string>

std::vector<std::string> split( const std::string & text , char delim ) {
   std::istringstream istr { text } ;
   std::vector<std::string> tokens ;
   std::string word ;
   while ( std::getline( istr , word , delim ) ) {
      tokens.push_back( word ) ;
   }
   return tokens ;
}

bool isNeighbouring( std::vector<int> & firstVec , std::vector<int> &
      secondVec ) {
   std::sort( firstVec.begin( ) , firstVec.end( ) ) ;
   std::sort( secondVec.begin( ) , secondVec.end( ) ) ;
   std::vector<int> intersect ;
   std::set_intersection( firstVec.begin( ) , firstVec.end( ) , 
	 secondVec.begin( ) , secondVec.end( ) , std::back_inserter( 
	    intersect ) ) ;
   return intersect.size( ) > 0 ;
}

int main( ) {
   std::cout << "Please enter some positive integers separated by blanks!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens { split( line , ' ' ) } ;
   std::vector<int> numbers ;
   for ( auto s : tokens ) 
      numbers.push_back( std::stoi( s ) ) ;
   int len = numbers.size( ) ;
   if ( numbers[0] == 0 ) 
      std::cout << -1 << '\n' ;
   else { 
      if ( numbers[0] >= len - 1 ) 
	 std::cout << 1 << '\n' ;
      else {
	 std::vector<std::vector<int>> indices ;
	 std::vector<int> currentIndices ;
	 for ( int i = 0 ; i < len - 1 ; i++ ) {
	    if ( numbers[i] == 0 ) 
	       currentIndices.push_back( i ) ;
	    else {
	       for ( int j = 0 ; j < numbers[i] + 1 ; j++ ) 
		  currentIndices.push_back( i + j ) ;
	    }
	    indices.push_back( currentIndices ) ;
	    currentIndices.clear( ) ;
	 }
	 std::vector<std::vector<int>> neighbours ;
	 neighbours.push_back( *indices.begin( ) ) ;
	 for ( int i = 1 ; i < len - 1 ; i++ ) {
	    auto aVec = neighbours.back( ) ;
	    if ( std::find( aVec.begin( ) , aVec.end( ) , len - 1 ) != 
		  aVec.end( ) ) 
	       break ;
	    if ( indices[i].size( ) > 1 && isNeighbouring( neighbours.back( ) ,
		     indices[i] ) ) 
	       neighbours.push_back( indices[i] ) ;
	 }
	 if ( std::find( neighbours.back( ).begin( ) , neighbours.back( ).end( ) , 
		  len - 1 ) == neighbours.back( ).end( ) ) 
	    std::cout << -1 << '\n' ;
	 else 
	    std::cout << neighbours.size( ) << '\n' ;
      }
   }
   return 0 ;
}
