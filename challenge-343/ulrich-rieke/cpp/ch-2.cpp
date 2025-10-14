#include <iostream>
#include <string>
#include <sstream>
#include <vector>
#include <algorithm>
#include <utility>
#include <iterator>

std::vector<std::string> split( const std::string & text , const char delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr , word , delimiter ))
      tokens.push_back( word ) ;
   return tokens ;
}

//order by number of 1 in the second element of each matrix row
//if these are equal see whether the entry in the second element of the
//first row that is denoted by the first element in the second row equals 0
bool mySorter( const std::pair<int , std::vector<int>> & firstRow , 
      const std::pair<int , std::vector<int>> & secondRow ) {
   int firstOnes = std::count( firstRow.second.begin( ) , firstRow.second.end( ) , 1 ) ;
   int secondOnes = std::count( secondRow.second.begin( ) , secondRow.second.end( ) , 
	 1 ) ;
   if ( firstOnes != secondOnes ) {
      return firstOnes < secondOnes ;
   }
   else {
      return firstRow.second[secondRow.first] == 0 ;
   }
}

int main( ) {
   std::cout << "Enter a quadratic matrix of n row of n 0 or 1, <enter> to end!\n" ;
   std::string line ;
   std::vector<std::pair<int , std::vector<int>>> matrix ;
   int counter = 0 ;
   std::getline( std::cin , line ) ;
   while ( ! line.empty( ) ) {
      auto tokens { split( line , ' ' ) } ;
      std::vector<int> numbers ;
      for ( auto s : tokens ) 
	 numbers.push_back( std::stoi( s ) ) ;
      matrix.push_back( std::make_pair( counter , numbers )) ;
      counter++ ;
      std::cout << "Enter a quadratic matrix of n rows of n 0 or 1 , <enter> to end!\n";
      std::getline( std::cin , line ) ;
   }
   std::sort( matrix.begin( ) , matrix.end( ) , mySorter ) ;
   std::cout << "Team " << std::prev( matrix.end( ))->first << '\n' ;
   return 0 ;
}
