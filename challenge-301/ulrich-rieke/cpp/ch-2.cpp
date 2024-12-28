#include <string>
#include <vector>
#include <sstream>
#include <algorithm>
#include <iostream>

std::vector<std::string> split( const std::string & text , char delim ) {
   std::istringstream istr { text } ;
   std::vector<std::string> tokens ;
   std::string word ;
   while ( std::getline( istr , word , delim ) ) {
      tokens.push_back( word ) ;
   }
   return tokens ;
}

std::string to_binary_string( int num ) {
   std::string binary ;
   while ( num != 0 ) {
      int remainder = num % 2 ;
      binary.append( std::to_string( remainder ) ) ;
      num /= 2 ;
   }
   std::reverse( binary.begin( ) , binary.end( ) ) ;
   return binary ;
}

//the Hamming distance is the difference in set bits between the orred 
//and the anded bitwise combination of 2 integers
int hamming_dist( int a , int b ) {
   int orred = a | b ;
   int anded = a & b ;
   std::string orstring { to_binary_string( orred ) } ;
   std::string andstring { to_binary_string( anded ) } ;
   auto orones = std::count( orstring.begin( ) , orstring.end( ) , '1' ) ;
   auto andones = std::count( andstring.begin( ) , andstring.end( ) , 
	 '1' ) ;
   return ( static_cast<int>( orones ) - static_cast<int>( andones ) ) ;
}

std::vector<std::vector<int>> create_two_combinations( const 
      std::vector<int> & numbers ) {
   int len = static_cast<int>( numbers.size( ) ) ;
   std::vector<std::vector<int>> combis_of_two ;
   for ( int i = 0 ; i < len - 1 ; i++ ) {
      std::vector<int> nums ;
      nums.push_back( numbers[i] ) ;
      for ( int j = i + 1 ; j < len ; j++ ) {
	 nums.push_back( numbers[j] ) ;
	 combis_of_two.push_back( nums ) ;
	 nums.pop_back( ) ;
      }
   }
   return combis_of_two ;
}

int main( ) {
   std::cout << "Enter some integers separated by blanks!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens { split( line , ' ' ) } ;
   std::vector<int> numbers ;
   for ( auto s : tokens ) 
      numbers.push_back( std::stoi( s ) ) ;
   int sum = 0 ;
   auto combis { create_two_combinations( numbers ) } ;
   for ( auto vec : combis ) {
      sum += hamming_dist( vec[0] , vec[1] ) ;
   }
   std::cout << sum << '\n' ;
   return 0 ;
}
