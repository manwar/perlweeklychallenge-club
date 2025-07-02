#include <iostream>
#include <string>
#include <vector>
#include <numeric>

int main( ) {
   std::cout << "Enter a word with lowercase English letters and one ?!\n" ;
   std::string word ;
   std::getline( std::cin , word ) ;
   std::vector<char> characters( 26 ) ;
   std::iota( characters.begin( ) , characters.end( ) , 'a' ) ;
   auto found = word.find( '?' ) ;
   char left_neighbour = word.substr( 0 , found  ).back( ) ;
   char right_neighbour = word.substr( found + 1 ).front( ) ;
   std::vector<char> remaining ;
   for ( auto c : characters ) {
      if (c != left_neighbour && c != right_neighbour ) {
	 remaining.push_back( c ) ;
      }
   }
   std::string changed { word.substr( 0 , found  ) } ;
   changed.push_back( remaining[0] ) ;
   changed.append( word.substr( found + 1 ) ) ;
   std::cout << changed << '\n' ;
   return 0 ;
}
