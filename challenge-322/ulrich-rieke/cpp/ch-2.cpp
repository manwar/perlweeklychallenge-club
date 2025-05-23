#include <iostream>
#include <vector>
#include <string>
#include <utility>
#include <sstream>
#include <algorithm>

std::vector<std::string> split( const std::string & text , char delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr , word , delimiter ) ) 
      tokens.push_back( word ) ;
   return tokens ;
}

int main( ) {
   std::cout << "Enter some integers separated by blanks!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens { split( line , ' ' ) } ;
   std::vector<int> numbers ;
   for ( auto s : tokens ) 
      numbers.push_back( std::stoi( s ) ) ;
   std::vector<int> for_comp { numbers } ;
   std::sort( for_comp.begin( ) , for_comp.end( ) ) ;
   auto up_to = std::unique( for_comp.begin( ) , for_comp.end( ) ) ;
   std::vector<int> solution ;
   int n = 0 ;
   std::vector<std::pair<int , int>> pairs ;
   for ( auto it  = for_comp.begin( ) ; it != up_to ; ++it ) {
      pairs.push_back( std::make_pair( ++n , *it )) ;
   }
   for ( int i : numbers ) {
      int num = std::find_if( pairs.begin( ) , pairs.end( ) , [i]( auto & p ){
	    return p.second == i ;})->first ;
      solution.push_back( num ) ;
   }
   std::cout << "( " ;
   for ( auto i : solution ) 
      std::cout << i << ' ' ;
   std::cout << ")\n" ;
   return 0 ;
}
