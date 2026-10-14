#include <iostream>
#include <string>
#include <algorithm>
#include <sstream>
#include <vector>

std::vector<std::string> split( const std::string & text , const char
      delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr , word , delimiter ) )
      tokens.push_back( word ) ;
   return tokens ;
}

bool condition( const std::vector<std::string> & combi ) {
   int l { static_cast<int>( combi[0].length( ) ) } ;
   std::vector<std::string> recombined ;
   for ( int i = 0 ; i < l ; i++ ) {
      std::string combined ;
      for ( auto w : combi ) {
         combined.append( w.substr( i , 1 ) ) ;
      }
      recombined.push_back( combined ) ;
   }
   return recombined == combi ;
}

std::vector<std::vector<std::string>> createCombinations(
      const std::vector<std::string> & selection , int combinum ) {
   std::vector<std::vector<std::string>> allCombis ;
   //create a combination by permutating a selection array and picking a 
   //member of the vector in dependence of the value of the selection array,
   //tribute to mitchnull in Stack Overflow
   int n { static_cast<int>( selection.size( ) )} ;
   std::vector<bool> v ( n ) ;
   std::fill( v.end( ) - combinum , v.end( ) , true ) ;
   do {
      std::vector<std::string> choice ;
      for ( int i = 0 ; i < n ; i++ ) {
         if ( v[i] ) {
            choice.push_back( selection[i] ) ;
         }
      }
      allCombis.push_back( choice ) ;
   } while ( std::next_permutation( v.begin( ) , v.end( ) ) ) ;
   return allCombis ;
}

int main( ) {
   std::cout << "Enter some words with an equal number of letters!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens { split( line , ' ' ) } ;
   auto allCombis { createCombinations( tokens , static_cast<int>(
            tokens[0].length( ) ) ) } ;
   std::vector<std::vector<std::string>> selection ;
   for ( auto vec : allCombis ) {
      //first , sort the vector!! Otherwise you miss permutations!
      std::sort( vec.begin( ) , vec.end( ) ) ;
      do {
         if ( condition( vec ) ) {
            selection.push_back( vec ) ;
         }
      } while ( std::next_permutation( vec.begin( ) , vec.end( ) ) ) ;
   }
   std::cout << '(' ;
   for ( auto vec : selection ) {
      std::cout << "( " ;
      for ( auto w : vec ) {
         std::cout << w << ' ' ;
      }
      std::cout << ')' ;
   }
   std::cout << ")\n" ;
   return 0 ;
}
