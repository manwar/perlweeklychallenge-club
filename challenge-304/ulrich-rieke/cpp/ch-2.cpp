#include <string>
#include <vector>
#include <sstream>
#include <numeric>
#include <iostream>
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
   auto tokens { split( line , ' ' ) } ;
   std::vector<int> numbers ;
   for ( auto s : tokens ) 
      numbers.push_back( std::stoi( s ) ) ;
   std::cout << "Enter a number less than or equal the length of the array!\n" ;
   int n ;
   std::cin >> n ;
   double maxi = static_cast<double>(*std::min_element( numbers.begin( ) , 
	    numbers.end( ) )) ;
   int len = numbers.size( ) ;
   for ( int i = 0 ; i < len - n + 1 ; i++ ) {
      std::vector<int> partial_array( numbers.begin( ) + i , numbers.begin( ) + i
	    + n ) ;
      double avg = static_cast<double>( std::accumulate( partial_array.begin( ) ,
	       partial_array.end( ) , 0.0 )) / static_cast<double>( n ) ;
      if ( avg > maxi ) 
	 maxi = avg ;
   }
   std::cout << maxi << '\n' ;
   return 0 ;
}
