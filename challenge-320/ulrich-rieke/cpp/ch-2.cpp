#include <iostream>
#include <sstream>
#include <numeric>
#include <string>
#include <vector>
#include <cstdlib>

std::vector<std::string> split( const std::string & text , char delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr , word , delimiter ) ) 
      tokens.push_back( word ) ;
   return tokens ;
}

int digitsum( int number ) {
   int sum = 0 ;
   while ( number != 0 ) {
      sum += number % 10 ;
      number /= 10 ;
   }
   return sum ;
}

int main( ) {
   std::cout << "Enter some positive integers separated by blanks!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens { split( line , ' ' ) } ;
   std::vector<int> numbers ;
   for ( auto s : tokens ) 
      numbers.push_back( std::stoi( s ) ) ;
   int numbersum = std::accumulate( numbers.begin( ) , numbers.end( ) , 0 ) ;
   std::vector<int> digitsums ;
   for ( int n : numbers ) {
      digitsums.push_back( digitsum( n ) ) ;
   }
   int all_digit_sum = std::accumulate( digitsums.begin( ) , digitsums.end( ) , 
	 0 ) ;
   std::cout << std::abs( all_digit_sum - numbersum ) << '\n' ;
   return 0 ;
}

