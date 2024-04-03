#include <iostream>
#include <string>
#include <vector>
#include <map>
#include <utility>
#include <algorithm>

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
   std::cout << "Enter an even number of integers, separated by blanks!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   std::vector<std::string> numberterms { split( line , " " ) } ;
   std::vector<int> firstNumbers, secondNumbers ;
   for ( auto s : numberterms ) 
      firstNumbers.push_back( std::stoi( s ) ) ;
   std::cout << "Enter an even number of integers, yet again!\n" ;
   line.clear( ) ;
   std::getline( std::cin , line ) ;
   numberterms.clear( ) ;
   numberterms = split( line , " " ) ;
   for ( auto s : numberterms ) 
      secondNumbers.push_back( std::stoi( s ) ) ;
   //regard consecutive numbers as elements of a pair and add second 
   //element to an existing one or set it as new
   std::map<int , int> pairs ;
   int len = firstNumbers.size( ) ;
   int pos = 0 ;
   while ( pos < len - 1 ) {
      pairs[firstNumbers[pos]] += firstNumbers[pos + 1] ;
      pos += 2 ;
   }
   len = secondNumbers.size( ) ;
   pos = 0 ;
   while ( pos < len - 1 ) {
      pairs[secondNumbers[pos]] += secondNumbers[pos + 1] ;
      pos += 2 ;
   }
   std::vector<std::pair<int , int>> neighbours { pairs.begin( ) , 
      pairs.end( ) } ;
   std::sort( neighbours.begin( ) , neighbours.end( ) , []( auto p1 , 
	    auto p2) { return p1.first < p2.first ; } ) ;
   std::cout << "[ " ;
   for ( auto it = neighbours.begin( ) ; it != neighbours.end( ) ; it++ ) {
      std::cout << '[' << it->first << ',' << it->second << "] " ;
   }
   std::cout << "]\n" ;
   return 0 ;
}


