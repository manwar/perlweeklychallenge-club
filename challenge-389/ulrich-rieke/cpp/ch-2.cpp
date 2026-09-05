#include <iostream>
#include <sstream>
#include <vector>
#include <string>
#include <algorithm>
#include <numeric>

std::vector<std::string> split( const std::string & text , const char 
      delimiter ) {
   std::vector<std::string> tokens ;
   std::string word ;
   std::istringstream istr { text } ;
   while ( std::getline( istr , word , delimiter ) )
      tokens.push_back( word ) ;
   return tokens ;
}

bool isUndulating( const std::vector<int> & numbers ) {
   bool result = false ;
   if ( numbers.size( ) == 1 ) {
      result =  true ;
   }
   if ( numbers.size( ) == 2 ) {
      result =  (numbers[0] != numbers[1]) ;
   }
   if ( numbers.size( ) > 2 ) {
      std::vector<bool> truthvalues ;
      int len { static_cast<int>(numbers.size( ) ) } ;
      std::vector<int> differences( len ) ;
      std::adjacent_difference( numbers.begin( ) , numbers.end( ) , 
            differences.begin( ) ) ;
      for ( int i = 1 ; i < len - 1 ; i++ ) {
         if ( (differences[i] > 0 && differences[i + 1] < 0) ||
               (differences[i] < 0 && differences[i + 1] > 0 ))
            truthvalues.push_back( true ) ;
         else 
            truthvalues.push_back( false ) ;
      }
      result = std::all_of( truthvalues.begin( ) , truthvalues.end( ) , 
            []( auto b) { return b ; }) ;
   }
   return result ;
}

std::vector<std::vector<int>> createSubarrays( const std::vector<int> 
      & numbers ) {
   std::vector<std::vector<int>> subarrays ;
   int len { static_cast<int>( numbers.size( ) ) } ;
   for ( int i = 0 ; i < len - 1 ; i++ ) {
      std::vector<int> array ;
      int current = i ;
      while ( current != len ) {
         array.push_back( numbers[current] ) ;
         subarrays.push_back( array ) ;
         current++ ;
      }
   }
   return subarrays ;
}


int main( ) {
   std::cout << "Enter some integers separated by whitespace!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens { split( line , ' ' ) } ;
   std::vector<int> numbers ;
   for ( auto s : tokens ) 
      numbers.push_back( std::stoi( s ) ) ;
   auto subarrays { createSubarrays( numbers ) } ;
   std::vector<int> sizes ;
   for ( auto vec : subarrays ) {
      int starter { vec[0] } ;
      if ( std::all_of( vec.begin( ) , vec.end( ) , [starter]( const int 
                  n ) { return n == starter ; } )) 
         sizes.push_back( 1 ) ;
      else {
         if ( isUndulating( vec ) ) 
            sizes.push_back( vec.size( ) ) ;
      }
   }
   std::cout << *std::max_element( sizes.begin( ) , sizes.end( ) ) << 
      '\n' ;
   return 0 ;
}
