#include <iostream>
#include <string>
#include <algorithm>
#include <regex>
#include <vector>
#include <numeric>

int digitsum( int number ) {
   int sum = 0 ;
   while ( number != 0 ) {
      sum += number % 10 ;
      number /= 10 ;
   }
   return sum ;
}

int main( ) {
   std::cout << "Enter a term consisting of digits only!\n" ;
   std::string term ;
   std::getline( std::cin , term ) ;
   std::reverse( term.begin( ) , term.end( ) ) ;
   int payload = std::stoi(term.substr( 0 , 1 )) ;
   int count = 1 ;
   std::vector<int> sums ;
   std::string num_pattern = "\\d" ;
   auto numberpattern = std::regex( num_pattern ) ;
   for ( int i = 1 ; i < term.length( ) ; i++ ) {
      if ( std::regex_match( term.substr( i , 1 ) , numberpattern ) ) {
	 int number = std::stoi(term.substr( i , 1 )) ;
	 if ( count % 2 == 1 ) {
	    int localsum = 2 * number ;
	    if ( localsum < 10 ) {
	       sums.push_back( localsum ) ;
	    }
	    else {
	       int the_sum = digitsum( localsum ) ;
	       sums.push_back( the_sum ) ;
	    }
	 }
	 else {
	    sums.push_back( number ) ;
	 }
	 count++ ;
      }
   }
   int totalsum = std::accumulate( sums.begin( ) , sums.end( ) , 0 ) ;
   std::cout << std::boolalpha << ((( totalsum + payload ) % 10) == 0) << 
      '\n' ;
   return 0 ;
}


