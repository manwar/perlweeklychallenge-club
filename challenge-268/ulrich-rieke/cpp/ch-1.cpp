#include <iostream>
#include <vector>
#include <ranges>
#include <algorithm>
#include <string>
#include <utility>

std::vector<std::string> split( const std::string & startline ,
      const std::string & sep ) {
   std::vector<std::string> separated ;
   std::string::size_type start { 0 } ;
   std::string::size_type pos ;
   do {
      pos = startline.find_first_of( sep , start ) ;
      separated.push_back( startline.substr(start , pos - start )) ;
      start = pos + 1 ;
   } while ( pos != std::string::npos ) ;
   return separated ;
}

int main( ) {
   std::cout << "Enter some integers, separated by blanks!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   std::cout << "Enter the same number of integers, separated by blanks!\n" ;
   std::string sec_line ;
   std::getline( std::cin , sec_line ) ;
   std::vector<std::string> firstNums { split( line , " " ) } ,
      secondNums { split( sec_line , " " ) } ;
   std::vector<int> firstNumbers , secondNumbers ;
   for ( auto s : firstNums ) 
      firstNumbers.push_back( std::stoi( s ) ) ;
   for ( auto s : secondNums ) 
      secondNumbers.push_back( std::stoi( s ) ) ;
   std::ranges::sort( firstNumbers ) ;
   std::ranges::sort( secondNumbers ) ;
   std::vector<std::pair<int , int>> pairs ;
   for ( int i = 0 ; i < firstNumbers.size( ) ; i++ ) 
      pairs.push_back( std::make_pair( firstNumbers[i] , secondNumbers[i] )) ;
   int comp = pairs.begin( )->second - pairs.begin( )->first ;
   if ( std::all_of( pairs.begin( ) , pairs.end( ) , [comp]( auto p ) {
	    return p.second - p.first == comp ; } )) 
      std::cout << comp << '\n' ;
   else 
      std::cout << '\n' ;
   return 0 ;
}
