#include <iostream>
#include <string>
#include <algorithm>
#include <utility>
#include <vector>
#include <sstream>

std::vector<std::string> split( const std::string & text , char delim ) {
   std::istringstream istr { text } ;
   std::vector<std::string> tokens ;
   std::string word ;
   while ( std::getline( istr , word , delim ) ) {
      tokens.push_back( word ) ;
   }
   return tokens ;
}

std::vector<std::pair<int , std::string>> match_indices( const std::string 
      &text , const std::string & part ) {
   std::vector<std::pair<int , std::string>> indices ;
   auto pos = text.find( part ) ;
   while ( pos != std::string::npos ) {
      indices.push_back( std::make_pair( pos , part ) ) ;
      if ( pos < text.length( ) - 1 ) {
	 pos++ ;
      }
      pos = text.find( part , pos ) ;
   }
   return indices ;
}

int main( ) {
   std::cout << "Enter a long word!\n" ;
   std::string word ;
   std::getline(std::cin ,  word ) ;
   std::cout << "Enter a list of words separated by blanks!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens { split( line, ' ' ) } ;
   if ( std::any_of( tokens.begin( ) , tokens.end( ) , [word]( const auto t) {
	    return word.find( t ) == std::string::npos ; } ) ) {
      std::cout << std::boolalpha << false << '\n' ;
   }
   else {
      std::vector<std::vector<int>> allIndices ; //for the list of all the indices
      //single words have in the long word
      for ( auto s : tokens ) {
	 auto matches { match_indices( word , s ) } ;
	 for ( auto p : matches ) {
	    std::vector<int> word_indices ;
	    for ( int i = p.first ; i < p.first + p.second.length( ) ; i++ ) 
	       word_indices.push_back( i ) ;
	    allIndices.push_back( word_indices ) ;
	 }
      }
      //now we do a pairwise comparison of all the indices in allIndices. Their
      //intersections must be zero! Before we can determine the intersection we
      //must sort the vectors to fulfil the most important precondition of the
      //set_intersection algorithm
      bool result = true ; //set result to be true
      for ( int i = 0 ; i < allIndices.size( ) - 1 ; i++ ) {
	 std::sort( allIndices[i].begin( ) , allIndices[i].end( ) ) ;
	 std::sort( allIndices[i + 1].begin( ) , allIndices[i + 1].end( ) ) ;
	 std::vector<int> common ;
	 std::set_intersection( allIndices[i].begin( ) , allIndices[i].end( ) , 
	    allIndices[i + 1].begin( ) , allIndices[i + 1].end( ) , 
	    std::back_inserter( common ) ) ;
	 if ( common.size( ) > 0 ) {
	    result = false ; //proven wrong, so set result = false
	    break ;
	 }
      }
      std::cout << std::boolalpha << result << '\n' ;
   }
   return 0 ;
}


