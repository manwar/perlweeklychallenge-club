#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

std::vector<std::string> split( const std::string & startline , 
      const std::string & sep ) {
   std::vector<std::string> separated ;
   std::string::size_type start { 0 } ;
   std::string::size_type pos ;
   do {
      pos = startline.find_first_of( sep , start ) ;
      separated.push_back( startline.substr( start , pos - start ) ) ;
      start = pos + 1 ;
   } while ( pos != std::string::npos ) ;
   return separated ;
}

int main( ) {
   std::cout << "Enter an array of positive integers >= 1 , separated by blanks!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   std::vector<std::string> numberstrings { split( line , " " ) } ;
   std::vector<int> numbers ;
   for ( auto & s : numberstrings ) 
      numbers.push_back( std::stoi( s ) ) ;
   int comparedTo { numbers[ 0 ] } ;
   int len = numbers.size( ) ;
   if ( std::all_of( numbers.begin( ) , numbers.end( ) , [comparedTo]( int i ) {
	    return i == comparedTo ; } ) ) {
      std::cout << comparedTo * len << std::endl ;
   }
   else {
      int sum = 0 ;
      for ( int i = 0 ; i < len ; i++ ) {
	 sum += 1 ; // representing the floor of dividing a number by itself
	 if ( i < len - 1 ) {
	    for ( int j = i + 1 ; j < len ; j++ ) {
	       if ( numbers[ i ] != numbers[ j ] ) {
		  sum += numbers[ i ] / numbers[ j ] ;
		  sum += numbers[ j ] / numbers[ i ] ;
	       }
	    }
	 }
      }
      std::cout << sum << std::endl ;
   }
   return 0 ;
}
