#include <vector>
#include <string>
#include <sstream>
#include <utility>
#include <iostream>
#include <map>
#include <cstdlib>
#include <set>
#include <algorithm>

std::vector<std::string> split( const std::string & text , char delim ) {
   std::istringstream istr { text } ;
   std::vector<std::string> tokens ;
   std::string word ;
   while ( std::getline( istr , word , delim ) ) {
      tokens.push_back( word ) ;
   }
   return tokens ;
}

bool is_neighbouring( const std::pair<int , int> & firstOne , 
      const std::pair<int , int> & secondOne ) {
   return (firstOne.first == secondOne.first && ( std::abs( 
	       firstOne.second - secondOne.second ) == 1 )) ||
      (std::abs( firstOne.first - secondOne.first) == 1 && 
       firstOne.second == secondOne.second ) ;
}

bool isValid( const std::vector<std::pair<int , int>> & posivec ) {
   int len = static_cast<int>( posivec.size( ) ) ;
   for ( int i = 0 ; i < len - 1 ; i++ ) {
      if ( ! is_neighbouring( posivec[i] , posivec[i + 1 ] )) {
	 return false ;
      }
   }
   std::set<std::pair<int , int>> posiset( posivec.begin( ) , 
	 posivec.end( ) ) ;
   if ( posiset.size( ) != posivec.size( ) ) 
      return false ;
   return true ;
}

int main( ) {
   std::cout << "Enter some letters separated by whitespace!\n" ;
   std::cout << "Enter <return> to end!\n" ;
   std::string line ;
   std::vector<std::vector<char>> letterarray ;
   std::getline( std::cin , line ) ;
   while (! line.empty( )) {
      auto tokens { split( line , ' ' ) } ;
      std::vector<char> letterline ;
      for ( auto s : tokens ) {
	 letterline.push_back( static_cast<char>(s[0] ) ) ;
      }
      letterarray.push_back( letterline ) ;
      std::getline( std::cin , line ) ;
   }
   std::cout << "Enter a word!\n" ;
   std::string word ;
   std::getline( std::cin , word ) ;
   std::map<char , std::vector<std::vector<std::pair<int , int>>>> 
      letterpositions ;
   int arraylen { static_cast<int>( letterarray.size( ) ) } ;
   int rowlen { static_cast<int>( letterarray[0].size( ) ) } ;
   for ( int r = 0 ; r < arraylen ; r++ ) {
      for ( int c = 0 ; c < rowlen ; c++ ) {
	 char letter { letterarray[r][c] } ;
	 std::vector<std::pair<int, int>> aPosition ;
	 aPosition.push_back( std::make_pair( r , c ) ) ;
	 if ( letterpositions.find( letter ) == letterpositions.end( ) ) {
	    std::vector<std::vector<std::pair<int , int>>>
	       positions_of_letter ;
	    positions_of_letter.push_back( aPosition ) ;
	    letterpositions[letter] = positions_of_letter ;
	 }
	 else {
	    auto posis {letterpositions.find( letter )->second } ;
	    posis.push_back( aPosition ) ;
	    letterpositions[ letter ] = posis ;
	 }
      }
   }
   if ( arraylen * rowlen < static_cast<int>(word.length( ) ) ) {
      std::cout << "false\n" ;
   }
   else {
      std::vector<std::vector<std::pair<int , int>>> sequences ;
      for ( char ch : word ) {
	 if ( letterpositions.find( ch ) == letterpositions.end( ) ) {
	    std::cout << "false\n" ;
	    break ;
	 }
	 else {
	    std::vector<std::vector<std::pair<int , int>>> currentPositions 
	    { letterpositions.find( ch )->second } ;
	    if ( sequences.empty( ) ) {
	       for ( auto vec : currentPositions ) 
		  sequences.push_back( vec ) ;
	    }
	    else {
	       std::vector<std::vector<std::pair<int , int>>> combis ;
	       for ( auto posi : sequences ) {
		  for ( auto p : currentPositions ) {
		     posi.push_back( p[0] ) ;
		     combis.push_back( posi ) ;
		     posi.pop_back( ) ;
		  }
	       }
	       sequences = std::move( combis ) ;
	       combis.clear( ) ;
	       std::vector<std::vector<std::pair<int , int>>> selected ;
	       for ( auto vec : sequences ) {
		  if ( isValid( vec ) ) {
		     selected.push_back( vec ) ;
		  }
	       }
	       sequences = std::move( selected ) ;
	       selected.clear( ) ;
	    }
	 }
      }
      if ( std::any_of( sequences.begin( ) , sequences.end( ) , 
	       [word]( const auto seq ) { return seq.size( ) == 
	       word.length( ) ; } ) ) 
	 std::cout << "true\n" ;
      else {
	 std::cout << "false\n" ;
      }
   }
   return 0 ;
}
