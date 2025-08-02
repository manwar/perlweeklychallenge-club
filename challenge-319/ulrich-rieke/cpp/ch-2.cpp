#include <vector>
#include <sstream>
#include <iostream>
#include <string>
#include <algorithm>

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
   std::cout << "Enter some integers separated by blanks!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto firsttokens { split( line , ' ' ) } ;
   std::cout << "Enter some more integers separated by blanks!\n" ;
   std::getline( std::cin , line ) ;
   auto secondtokens { split( line , ' ' ) } ;
   std::vector<int> firstnumbers , secondnumbers ;
   for ( auto s : firsttokens ) 
      firstnumbers.push_back( std::stoi( s ) ) ;
   for ( auto s : secondtokens ) 
      secondnumbers.push_back( std::stoi( s ) ) ;
   std::sort( firstnumbers.begin( ) , firstnumbers.end( ) ) ;
   std::sort( secondnumbers.begin( ) , secondnumbers.end( ) ) ;
   std::vector<int> common ;
   std::set_intersection( firstnumbers.begin( ) , firstnumbers.end( ) , 
	 secondnumbers.begin( ) , secondnumbers.end( ) , std::inserter( 
	    common, common.begin( ) ) ) ;
   if ( common.size( ) > 0 ) {
      std::cout << *std::min_element( common.begin( ) , common.end( ) ) << 
	 '\n' ;
   }
   else {
      std::cout << -1 << '\n' ;
   }
   return 0 ;
}
