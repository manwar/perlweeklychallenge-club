#include <string>
#include <iostream>
#include <regex>
#include <map>
#include <utility>
#include <vector>
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
   std::cout << "Enter a paragraph of words, <return> to end!\n" ;
   std::vector<std::string> paragraph ;
   std::string line ;
   std::getline( std::cin , line ) ;
   while ( ! line.empty( ) ) {
      paragraph.push_back( line ) ;
      std::getline( std::cin, line ) ;
   }
   std::cout << "Enter a banned word!\n" ;
   std::string banned ;
   std::cin >> banned ;
   std::regex pattern {R"((.+)\\W$)"} ;
   std::map<std::string, int> frequencies ;
   for ( auto & sentence : paragraph ) {
      std::vector<std::string> words { split( sentence , " " ) } ;
      for ( auto & word : words ) {
	 std::smatch matches ;
	 if (std::regex_match( word , matches , pattern ) ) {
	    frequencies[ matches[1] ]++ ;
	 }
	 else {
	    frequencies[ word ]++ ;
	 }
      }
   }
   std::vector<std::pair<std::string , int>> allPairs { frequencies.begin( ) , 
      frequencies.end( ) } ;
   std::sort( allPairs.begin( ) , allPairs.end( ) , []( const auto & a, const 
	    auto & b ) { return a.second > b.second ; } ) ;
   if ( allPairs.begin( )->first != banned ) {
      std::cout << allPairs.begin( )->first ;
   }
   else {
      std::cout << (allPairs.begin( ) + 1)->first ;
   }
   std::cout << '\n' ;
   return 0 ;
}


