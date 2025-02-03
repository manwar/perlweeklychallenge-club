#include <string>
#include <vector>
#include <iostream>
#include <sstream>
#include <utility>
#include <algorithm>

std::vector<std::string> split( const std::string & text , char delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr , word , delimiter ) ) {
      tokens.push_back( word ) ;
   }
   return tokens ;
}

int main( ) {
   std::cout << "Enter some integers separated by whitespace!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens { split( line , ' ' ) } ;
   std::vector<int> numbers ;
   for ( auto s : tokens )
      numbers.push_back( std::stoi( s ) ) ;
   std::vector<std::pair<int , int>> before_sort , after_sort ;
   int len = numbers.size( ) ;
   for ( int i = 0 ; i < len ; i++ ) {
      before_sort.push_back( std::make_pair( i , numbers[i] ) ) ;
   }
   std::sort( numbers.begin( ) , numbers.end( ) ) ;
   for ( int i = 0 ; i < len ; i++ ) {
      after_sort.push_back( std::make_pair( i , numbers[i] ) ) ;
   }
   std::vector<int> changed_indices ;
   for ( int i = 0 ; i < len ; i++ ) {
      if ( (before_sort.begin( ) + i)->second != (after_sort.begin( ) + i)->second )
	 changed_indices.push_back( (before_sort.begin( ) + i)->first ) ;
   }
   std::cout << "( " ;
   for ( int i : changed_indices ) 
      std::cout << i << ' ' ;
   std::cout << ")\n" ;
   return 0 ;
}
