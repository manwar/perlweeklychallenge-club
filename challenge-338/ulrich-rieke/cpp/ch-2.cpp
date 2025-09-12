#include <vector>
#include <string>
#include <iostream>
#include <algorithm>
#include <sstream>
#include <cstdlib>

std::vector<std::string> split( const std::string & text , char delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr , word , delimiter ) ) 
      tokens.push_back( word ) ;
   return tokens ;
}

int main( ) {
   std::cout << "Enter some integers separated by whitespace!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto firsttokens { split( line , ' ' ) } ;
   std::cout << "Enter some more integers separated by whitespace!\n" ;
   std::getline( std::cin , line ) ;
   auto secondtokens { split( line , ' ' ) } ;
   std::vector<int> firstnums , secondnums , differences ;
   for ( auto s : firsttokens ) 
      firstnums.push_back( std::stoi( s ) ) ;
   for ( auto s : secondtokens ) 
      secondnums.push_back( std::stoi( s ) ) ;
   for ( auto fit = firstnums.begin( ) ; fit != firstnums.end( ) ; ++fit ) {
      for ( auto sit = secondnums.begin( ) ; sit != secondnums.end( ) ; ++sit ) {
	 differences.push_back( std::abs( *fit - *sit ) ) ;
      }
   }
   std::cout << *std::max_element( differences.begin( ) , differences.end( ) ) <<
      '\n' ;
   return 0 ;
}

