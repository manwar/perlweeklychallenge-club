#include <string>
#include <iostream>
#include <tuple>
#include <vector>
#include <algorithm>
#include <iterator>

std::pair<int , int> reduceFraction( int numerator , int denominator ) {
   std::vector<int> firstdivisors ;
   std::vector<int> seconddivisors ;
   for ( int i = 1 ; i < numerator + 1 ; i++ ) {
      if ( numerator % i == 0 ) 
         firstdivisors.push_back( i ) ;
   }
   for ( int i = 1 ; i < denominator + 1 ; i++ ) 
      if ( denominator % i == 0 )
         seconddivisors.push_back( i ) ;
   std::vector<int> common ;
   std::set_intersection( firstdivisors.begin( ) , firstdivisors.end( ) , 
         seconddivisors.begin( ) , seconddivisors.end( ) ,
         std::back_inserter( common ) ) ;
   int gcd = *std::max_element( common.begin( ) , common.end( ) ) ;
   if ( gcd != 1 ) {
      return std::make_pair( numerator / gcd , denominator / gcd ) ;
   }
   else {
      return std::make_pair( numerator , denominator ) ;
   }
}

int main( ) {
   std::cout << "Enter a positive integer!\n" ;
   int number ;
   std::cin >> number ;
   std::vector<std::tuple<double , int , int>> fractions ;
   for ( int num = 1 ; num < number + 1 ; num++ ) {
      for ( int denom = 1 ; denom < number + 1 ; denom++ ) {
         double frac = static_cast<double>(num) / denom ;
         std::tuple<double , int , int> t ( frac , num , denom ) ;
         fractions.push_back( t ) ;
      }
   }
   std::sort( fractions.begin( ) , fractions.end( ) , []( const auto tu1 , 
            const auto tu2) { return std::get<0>(tu1) < std::get<0>(tu2 ) ;
         } ) ;
   std::vector<std::string> result ;
   for ( auto tu : fractions ) {
      auto myReduced = reduceFraction( std::get<1>( tu ) , 
            std::get<2>(tu ) ) ;
      std::string output = std::to_string( myReduced.first ) + "/" + 
         std::to_string( myReduced.second ) ;
      result.push_back( output ) ;
   }
   auto last = std::unique( result.begin( ) , result.end( ) ) ;
   std::copy( result.begin( ) , last , std::ostream_iterator<std::
         string> ( std::cout , " " ) ) ;
   std::cout << '\n' ;
   return 0 ;
}

