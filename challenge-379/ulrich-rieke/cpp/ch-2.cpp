#include <iostream>
#include <string>
#include <sstream>
#include <vector>
#include <algorithm>
#include <numeric>
#include <cmath>

std::vector<std::string> split ( const std::string &text , const char
      delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr , word , delimiter ) )
      tokens.push_back( word ) ;
   return tokens ;
}

//convert a number to all the digits in the given base. If any of these
//digits is greater than 9 it can't be an Armstrong number
bool isArmstrong( int number , int base ) {
   const int comparison { number } ;
   std::vector<int> digits ;
   while ( number != 0 ) {
      digits.push_back( number % base ) ;
      number /= base ;
   }
   if (std::any_of( digits.begin( ) , digits.end( ) , []( const int n) {
            return n > 9 ; } )) {
         return false ;
   }
   else {
      int len = digits.size( ) ;
      std::transform( digits.begin( ) , digits.end( ) , digits.begin( ) ,
            [len]( int a ) {return static_cast<int>( std::pow(
                  static_cast<double>( a ) , len )) ; } ) ;
      return std::accumulate( digits.begin( ) , digits.end( ) , 0 ) == 
         comparison ;
   }
}

int main( ) {
   std::cout << "Enter , separated by blanks, a base and a limit!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens { split( line , ' ' ) } ;
   int base { std::stoi( tokens[0] ) } ;
   int limit { std::stoi( tokens[1] ) } ;
   //by definition , all numbers from 0 to base - 1 are part of the solut.
   std::vector<int> solution ;
   for ( int i = 0 ; i < base ; i++ )
      solution.push_back( i ) ;
   for ( int i = base ; i < limit ; i++ ) {
      if ( isArmstrong( i , base ) )
         solution.push_back( i ) ;
   }
   std::cout << "( " ;
   for ( int i : solution ) 
      std::cout << i << ' ' ;
   std::cout << ")\n" ;
   return 0 ;
}
