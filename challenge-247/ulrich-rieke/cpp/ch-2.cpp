#include <vector>
#include <iostream>
#include <algorithm>
#include <utility>
#include <string>
#include <map>

bool mySorter( const std::pair<std::string , int> 
      & p1 , const std::pair<std::string , int> & p2 ) {
   if ( p1.second != p2.second ) {
      return p1.second > p2.second ;
   }
   else {
      return p1.first < p2.first ;
   }
}

int main( ) {
   std::cout << "Enter a string consisting of lowercase letters only!\n" ;
   std::string line ;
   std::cin >> line ;
   int len = line.length( ) ;
   std::map<std::string , int> frequencies ;
   for ( int pos = 0 ; pos < len - 1 ; pos++ ) {
      frequencies[ line.substr( pos , 2 )]++ ;
   }
   std::vector<std::pair<std::string , int>> allPairs ( frequencies.begin( ) ,
	 frequencies.end( ) ) ;
   std::sort( allPairs.begin( ) , allPairs.end( ) , mySorter ) ;
   std::cout << allPairs[0].first << std::endl ;
   return 0 ;
}

