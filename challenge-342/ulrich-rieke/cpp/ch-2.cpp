#include <iostream>
#include <string>
#include <algorithm>
#include <vector>
using namespace std::string_literals ;

int main( ) {
   std::cout << "Enter a string consisting of 0 and 1 only!\n" ;
   std::string word ;
   std::cin >> word ;
   std::vector<int> subsums ;
   int len = static_cast<int>( word.length( ) ) ;
   for ( int i = 1 ; i < len - 1 ; i++ ) {
      int zeroes = 0 ;
      for ( int pos = 0 ; pos < i + 1 ; pos++ ) {
	 if ( word.substr( pos , 1 ) == "0"s ) 
	    zeroes++ ;
      }
      int ones = 0 ;
      for ( int pos = i ; pos < len ; pos++ ) 
	 if ( word.substr( pos , 1 ) == "1"s ) 
	    ones++ ;
      subsums.push_back( zeroes + ones ) ;
   }
   std::cout << *std::max_element( subsums.begin( ) , subsums.end( ) ) << 
      '\n' ;
   return 0 ;
}
