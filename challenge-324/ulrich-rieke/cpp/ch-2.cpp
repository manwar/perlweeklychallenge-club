#include <string>
#include <algorithm>
#include <iostream>
#include <cmath>
#include <numeric>
#include <sstream>
#include <vector>

std::vector<std::string> split( const std::string & text , char delimiter ) {
   std::vector<std::string> tokens ;
   std::string word ;
   std::istringstream istr { text } ;
   while ( std::getline( istr , word , delimiter ))
      tokens.push_back( word ) ;
   return tokens ;
}

//create a binary string from a number! Fill up as many 0 at the front
//as necessary 
std::string createBinaryString( int length , int number ) {
   std::string binary ;
   while ( number != 0 ) {
      binary.append( std::to_string( number % 2 ) ) ;
      number /= 2 ;
   }
   int len = static_cast<int>( binary.length( ) ) ;
   if ( len < length ) {
      for ( int i = 0 ; i < length - len ; i++ ) {
	 binary.push_back( '0' ) ;
      }
   }
   //digits in the wrong order , have to be reversed ;
   std::reverse( binary.begin( ) , binary.end( ) ) ;
   return binary ;
}

int main( ) {
   std::cout << "Enter some integers separated by blanks!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens { split( line , ' ' ) } ;
   std::vector<int> numbers ;
   for ( auto s : tokens ) 
      numbers.push_back( std::stoi( s ) ) ;
   //creating a powerset of all subsets is equivalent to picking an 
   //element from a set if a given binary for all the numbers from 0 
   //to 2 ^ ( length of set ) - 1 contains a 1
   std::vector<std::string> allBinaries ;
   int len = numbers.size( ) ;
   for ( int i = 0 ; i < static_cast<int>( std::pow( 2.0 , len ) ) ; i++ ) {
      allBinaries.push_back( createBinaryString( len , i ) ) ;
   }
   std::vector<std::vector<int>> powerset ;
   for ( auto s : allBinaries ) {
      std::vector<int> selected ;
      int pos = 0 ;
      for ( char c : s ) {
	 if ( c == '1' ) {
	    selected.push_back(numbers[pos] ) ;
	 }
	 pos++ ;
      }
      powerset.push_back( selected ) ;
   }
   std::vector<int> sums ; // for the xor sums of sublists
   for ( auto vec : powerset ) {
      if (vec.size( ) == 1) 
	 sums.push_back( vec[0] ) ;
      else {
	 int subsum = std::accumulate( vec.begin( ) , vec.end( ) , 0 , []( 
		  int a , int b ){ return a ^ b ; } ) ;
	 sums.push_back( subsum ) ;
      }
   }
   std::cout << std::accumulate( sums.begin( ) , sums.end( ) , 0 ) << '\n' ;
   return 0 ;
}
