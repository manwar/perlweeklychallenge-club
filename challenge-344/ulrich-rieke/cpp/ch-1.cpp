#include <iostream>
#include <vector>
#include <string>
#include <sstream>
#include <algorithm>
#include <cmath>

std::vector<std::string> split( const std::string & text , const char
      delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr , word , delimiter ) ) 
      tokens.push_back( word ) ;
   return tokens ;
}

std::vector<int> decompose( int number ) {
   std::vector<int> result ;
   while ( number != 0 ) {
      result.push_back( number % 10 ) ;
      number /= 10 ;
   }
   std::reverse( result.begin( ) , result.end( ) ) ;
   return result ;
}

int main( ) {
   std::cout << "Enter some integers separated by blanks!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens { split( line , ' ' ) } ;
   std::vector<int> numbers ;
   for ( auto s : tokens ) 
      numbers.push_back( std::stoi( s ) ) ;
   std::cout << "Enter an integer!\n" ;
   int x ;
   std::cin >> x ;
   std::reverse( numbers.begin( ) , numbers.end( ) ) ;
   int total = 0 ;
   int pos = 0 ;
   for ( auto it = numbers.begin( ) ; it != numbers.end( ) ; ++it ) {
      total += *it * static_cast<int>(std::pow( 10 , pos )) ;
      pos++ ;
   }
   int result = total + x ;
   auto resultArray { decompose( result ) } ;
   std::cout << "( " ;
   for ( int i : resultArray ) {
      std::cout << i << ' ' ;
   }
   std::cout << ")\n" ;
   return 0 ;
}
