#include <vector>
#include <iostream>
#include <sstream>
#include <string>
#include <deque>

std::vector<std::string> split( const std::string & text , const char 
      delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr , word , delimiter ) ) 
      tokens.push_back( word ) ;
   return tokens ;
}

int main( ) {
   std::cout << "Enter some integers or -1 separated by blanks!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens { split( line , ' ' ) } ;
   std::vector<int> numbers ;
   for ( auto s : tokens ) 
      numbers.push_back( std::stoi( s ) ) ;
   std::deque<int> seen ;
   std::vector<int> answers ;
   int x = 0 ;
   int len = static_cast<int>( numbers.size( ) ) ;
   int pos = 0 ;
   while ( pos < len ) {
      int n = numbers[pos] ;
      if ( n > 0 ) {
	 seen.push_front( n ) ;
	 x = 0 ;
      }
      else {
	 if ( x < static_cast<int>(seen.size( ) ) ) {
	    answers.push_back( seen[x] ) ;
	 }
	 else {
	    answers.push_back( -1 ) ;
	 }
	 if ( pos < len - 1 && numbers[pos + 1] == -1 ) 
	    x++ ;
      }
      pos++ ;
   }
   std::cout << "( " ;
   for ( int i : answers ) {
      std::cout << i << ' ' ;
   }
   std::cout << ")\n" ;
   return 0 ;
}
