#include <iostream>
#include <string>
#include <sstream>
#include <vector>
#include <set>
#include <algorithm>
#include <utility>

std::vector<std::string> split( const std::string & text , char delim ) {
   std::istringstream istr { text } ;
   std::vector<std::string> tokens ;
   std::string word ;
   while ( std::getline( istr , word , delim ) ) {
      tokens.push_back( word ) ;
   }
   return tokens ;
}

int find_length( const std::vector<int> numbers , int index ) {
   std::set<int> mySet ;
   auto pair = mySet.insert( numbers[index] ) ;
   while (pair.second) {
      index = numbers[index] ;
      pair = mySet.insert( numbers[index] ) ;
   }
   return static_cast<int>(mySet.size( ) ) ;
}

int main( ) {
   std::cout << "Enter a permutation of positive integers 0..n - 1!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens { split( line , ' ' ) } ;
   std::vector<int> numbers , lengths ;
   for ( auto s : tokens ) 
      numbers.push_back( std::stoi( s ) ) ;
   int len = numbers.size( ) ;
   for ( int i = 0 ; i < len ; i++ ) 
      lengths.push_back( find_length( numbers , i ) ) ;
   std::cout << *std::max_element( lengths.begin( ) , lengths.end( ) ) << 
      '\n' ;
   return 0 ;
}

