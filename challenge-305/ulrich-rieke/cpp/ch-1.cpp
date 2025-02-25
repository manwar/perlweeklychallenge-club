#include <string>
#include <vector>
#include <sstream>
#include <iostream>
#include <cmath>
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

int to_decimal( const std::string  & binary ) {
   return std::stoi( binary , nullptr , 2 ) ;
}

bool is_prime( const int number ) {
   if ( number == 0 || number == 1 ) {
      return false ;
   }
   else {
      if ( number == 2 ) {
	 return true ;
      }
      else {
	 int limit = static_cast<int>( std::floor( std::sqrt(
		     static_cast<double>( number ) ))) ;
	 for ( int i = 2 ; i < limit + 1 ; i++ ) {
	    if ( number % i == 0 ) {
	       return false ;
	    }
	 }
	 return true ;
      }
   }
}

int main( ) {
   std::cout << "Enter some binary digits separated by blanks!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens { split( line , ' ' ) } ;
   std::vector<int> decimals ;
   std::string binary_string ;
   for ( auto s : tokens ) {
      binary_string += s ;
      decimals.push_back( to_decimal( binary_string ) ) ;
   }
   std::vector<bool> truth_values ;
   for ( int i : decimals ) {
      truth_values.push_back( is_prime( i ) ) ;
   }
   std::cout << '(' ;
   for ( auto v : truth_values ) {
      std::cout << std::boolalpha << v << ' ' ;
   }
   std::cout << ")\n" ;
   return 0 ;
}
