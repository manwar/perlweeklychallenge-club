#include <iostream>
#include <sstream>
#include <vector>
#include <string>
#include <numeric> 

std::vector<std::string> split( const std::string & text , char delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr , word , delimiter )) {
      tokens.push_back( word ) ;
   }
   return tokens ;
}

int main( ) {
   std::cout << "Please enter some integers, separated by blanks!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens { split( line , ' ' ) } ;
   std::vector<int> numbers ;
   for ( auto v : tokens ) 
      numbers.push_back( std::stoi( v ) ) ;
   int len = numbers.size( ) ;
   if ( len == 1 ) {
      std::cout << 0 << '\n' ;
   }
   else {
      int rightsum = 0 ;
      int leftsum = 0 ;
      int result = - 1 ;
      for ( int i = 0 ; i < len ; i++ ) {
	 if ( i == 0 ) {
	    leftsum = 0 ;
	 }
	 else {
	    leftsum = std::accumulate( numbers.begin( ) , numbers.begin( ) + i , 0 ) ;
	 }
	 if ( i == len - 1 ) {
	    rightsum = 0 ;
	 }
	 else {
	    rightsum = std::accumulate( numbers.begin( ) + i + 1 , numbers.end( ) , 0 ) ;
	 }
	 if ( leftsum == rightsum ) {
	    result = i ;
	    break ;
	 }
      }
      std::cout << result << '\n' ;
   }
   return 0 ;
}
