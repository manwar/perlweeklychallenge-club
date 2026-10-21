#include <string>
#include <vector>
#include <sstream>
#include <iostream>
#include <utility>
#include <algorithm>

std::vector<std::string> split( const std::string & text , const char
      delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr , word , delimiter ))
      tokens.push_back( word ) ;
   return tokens ;
}

int main( ) {
   std::cout << "Enter some integers from 1 to n in any order!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   std::vector<int> order , friends ;
   auto tokens { split( line , ' ' ) } ;
   for ( auto s : tokens )
      order.push_back( std::stoi( s ) ) ;
   std::cout << "Enter a subset of the integers in strictly ascending order!\n" ;
   line.clear( ) ;
   std::getline( std::cin , line ) ;
   auto secondtoks { split( line , ' ' ) } ;
   for ( auto s : secondtoks ) 
      friends.push_back( std::stoi( s ) ) ;
   std::vector<std::pair<int , int>> letterpositions ;
   int l { static_cast<int>( order.size( ) ) } ;
   for ( int i = 0 ; i < l ; i++ ) {
      letterpositions.push_back( std::make_pair( i , order[i] )) ;
   }
   std::vector<std::pair<int , int>> friendpositions ;
   for ( int n : friends ) {
      auto found = std::find_if( letterpositions.begin( ) , letterpositions.end() ,
            [n]( const auto & p) { return p.second == n ; } ) ;
      friendpositions.push_back( *found ) ;
   }
   std::sort( friendpositions.begin( ) , friendpositions.end( ) , []( const auto
            & p1 , const auto & p2 ) { return p1.first < p2.first ; } ) ;
   std::vector<int> solution ;
   for ( auto p : friendpositions ) {
      solution.push_back( p.second ) ;
   }
   std::cout << "( " ;
   for ( int n : solution ) {
      std::cout << n << ' ' ;
   }
   std::cout << ")\n" ;
   return 0 ;
}
