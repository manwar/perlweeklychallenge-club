#include <string>
#include <sstream>
#include <iostream>
#include <algorithm>
#include <utility> 
#include <vector>

std::vector<std::string> tokenize( const std::string & text , char delimiter ) {
   std::istringstream iss { text } ;
   std::string token ;
   std::vector<std::string> words ;
   while ( std::getline( iss, token , delimiter )) {
      words.push_back( token ) ;
   }
   return words ;
}

bool mySorter( const std::pair<std::string , int> &p1 , const std::pair<std::
      string , int> & p2 ) {
   return p1.second < p2.second ;
}

int main( ) {
   std::cout << "Enter some words , ending in numbers!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto words { tokenize( line, ' ' ) } ;
   std::vector<std::pair<std::string , int>> allPairs ;
   for ( auto w : words ) {
      auto pos = w.find_first_of("123456789") ;
      std::string firstPart { w.substr(0 , pos ) } ;
      allPairs.push_back( std::make_pair( firstPart , std::stoi( w.substr(pos )
		  ))) ;
   }
   std::sort( allPairs.begin( ) , allPairs.end( ) , mySorter ) ;
   for ( auto p : allPairs ) {
      std::cout << p.first << ' ' ;
   }
   std::cout << '\n' ;
   return 0 ;
}
