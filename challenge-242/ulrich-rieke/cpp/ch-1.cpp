#include <iostream>
#include <vector>
#include <algorithm>
#include <string>
#include <iterator>
#include <set>

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
   std::vector<std::string> numberstrings { split( line , " " ) } ;
   std::vector<int> firstNums , secondNums ;
   for ( auto s : numberstrings ) 
      firstNums.push_back( std::stoi( s )) ;
   std::cout << "Enter some more integers, separated by blanks!\n" ;
   std::getline( std::cin , line ) ;
   numberstrings.clear( ) ;
   numberstrings = split( line , " " ) ;
   for ( auto s : numberstrings ) 
      secondNums.push_back( std::stoi( s ) ) ;
   std::set<int> firstDiff , secondDiff ;
   std::set<int> firstSet( firstNums.begin( ) , firstNums.end( ) ) ;
   std::set<int> secondSet( secondNums.begin( ) , secondNums.end( ) ) ;
   std::set_difference( firstSet.begin( ) , firstSet.end( ) ,
	 secondSet.begin( ) , secondSet.end( ) , std::inserter( firstDiff , 
	    firstDiff.begin( ) ) ) ;
   std::set_difference( secondSet.begin( ) , secondSet.end( ) , 
	 firstSet.begin( ) , firstSet.end( ) , std::inserter( secondDiff , 
	    secondDiff.begin( ) )) ;
   std::cout << "(( " ;
   if ( firstDiff.size( ) > 0 ) {
      std::copy( firstDiff.begin( ) , firstDiff.end( ) ,
	    std::ostream_iterator<int>( std::cout , " " ) ) ;
   }
   if ( secondDiff.size( ) > 0 ) {
      std::cout << ") , ( " ;
      std::copy( secondDiff.begin( ) , secondDiff.end( ) , 
	    std::ostream_iterator<int>( std::cout , " " )) ;
      std::cout << " ))\n" ;
   }
   else {
      std::cout << "))\n" ;
   }
   return 0 ;
}
