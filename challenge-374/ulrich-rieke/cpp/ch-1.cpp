#include <iostream>
#include <string>
#include <set>
#include <vector>

bool condition( const std::string & word ) {
   static const std::set<char> vowels { 'a' , 'e' , 'i' , 'o' , 'u' } ;
   std::set<char> current { word.begin( ) , word.end( ) } ;
   return current == vowels ;
}

int main( ) {
   std::cout << "Enter a string!\n" ;
   std::string word ;
   std::cin >> word ;
   int len = word.length( ) ;
   std::vector<std::string> solution ;
   if ( len == 5 ) {
      if ( condition( word ) ) {
         solution.push_back( word ) ;
      }
   }
   if ( len > 5 ) {
      for ( int i = 0 ; i < len - 4 ; i++ ) {
         for ( int j = i + 5 ; j < len + 1 ; j++ ) {
            std::string substring { word.substr( i , j - i ) } ;
            if ( condition( substring ) ) {
               solution.push_back( substring ) ;
            }
         }
      }
   }
   std::cout << "( " ;
   if ( solution.size( ) > 0 ) {
      for ( auto w : solution ) {
         std::cout << w << ' ' ;
      }
   }
   std::cout << ")\n" ;
   return 0 ;
}

