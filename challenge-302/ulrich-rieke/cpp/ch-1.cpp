#include <string>
#include <sstream>
#include <vector>
#include <iostream>
#include <algorithm>
#include <cmath>

std::vector<std::string> split( const std::string & text , char delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream instr { text } ;
   std::string word ;
   while ( std::getline( instr , word , delimiter ) ) {
      if ( word.length( ) > 0 ) {
	 tokens.push_back( word ) ;
      }
   }
   return tokens ;
}

std::string to_binary_str( int n ) {
   std::string binary ;
   while ( n != 0 ) {
      int remainder = n % 2 ;
      binary.append( std::to_string( remainder ) ) ;
      n /= 2 ;
   }
   std::reverse( binary.begin( ) , binary.end( ) ) ;
   return binary ;
}

//to create a powerset of a set of n elements , write down all numbers from
//1 to 2 ^ n - 1 in binary form , then select those elements that correspond
//to a 1
std::vector<std::string> createBinariesForSelection( int number ) {
   std::vector<std::string> binaries ;
   int current = number ;
   auto startstring { to_binary_str( number ) } ;
   int len = static_cast<int>(startstring.length( ) ) ;
   while ( current > 0 ) {
      std::string numberstr { to_binary_str( current ) } ;
      std::string binarystring ;
      int rest = len - numberstr.length( ) ;
      if ( rest > 0 ) {
	 for ( int i = 0 ; i < rest ; i++ ) {
	    binarystring += '0' ;
	 }
	 binarystring += numberstr ;
      }
      else {
	 binarystring = numberstr ;
      }
      binaries.push_back( binarystring ) ;
      current-- ;
   }
   return binaries ;
}

bool condition( const std::vector<std::string> & subset , int x , int y ) {
   int zeroes = 0 ;
   int ones = 0 ;
   for ( auto it = subset.begin( ) ; it != subset.end( ); ++it ) {
      zeroes += std::count( it->begin( ) , it->end( ) , '0' ) ;
      ones += std::count( it->begin( ) , it->end( ) , '1' ) ;
   }
   return zeroes == x && ones == y ;
}

std::vector<std::vector<std::string>> findSubsets( const
      std::vector<std::string> & binaries ) {
   std::vector<std::vector<std::string>> allSubsets ;
   int len = static_cast<int>( binaries.size( ) ) ;
   auto binariesForSelection { createBinariesForSelection( 
	 static_cast<int>( std::pow( 2 , len ) - 1 ) ) } ;
   for ( auto it = binariesForSelection.begin( ) ; it != 
	 binariesForSelection.end( ) ; ++it ) {
      std::vector<std::string> currentSet ;
      int strsize = static_cast<int>(it->size( ) ) ;
      for ( int pos = 0 ; pos < strsize ; pos++ ) {
	 if ( it->substr( pos , 1 ) == "1" ) {
	    currentSet.push_back( binaries[ pos ] ) ;
	 }
      }
      allSubsets.push_back( currentSet ) ;
   }
   return allSubsets ;
}

int main( ) {
   std::cout << "Enter some binary strings separated by whitespace!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto input { split( line , ' ' ) } ;
   std::cout << "Enter the number x for the 0's!\n" ;
   int x ;
   std::cin >> x ;
   std::cout  << "Enter the number y for the 1's!\n" ;
   int y ;
   std::cin >> y ;
   auto allSubsets { findSubsets( input ) } ;
   int maxsize = 0 ;
   for ( auto strvec : allSubsets ) {
      if ( condition( strvec , x , y ) ) {
	 if ( strvec.size( ) > maxsize ) {
	    maxsize = strvec.size( ) ;
	 }
      }
   }
   std::cout << maxsize << '\n' ;
   return 0 ;
}
