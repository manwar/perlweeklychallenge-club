#include <iostream>
#include <string>

std::string convert( const std::string word , int shift ) {
   std::string converted ;
   for ( auto c : word ) {
      int num = static_cast<int>( c ) ;
      int shifted = num + shift ;
      if ( (shifted > 64 && shifted < 91) || ( shifted > 96 && shifted < 123 ) ) {
         converted.push_back( static_cast<char>( shifted ) ) ;
      }
      else {
         if ( (shifted > 90 ) && (shifted < 97 ) ) {
            converted.push_back( static_cast<char>( (shifted % 91 ) + 65 ) ) ;
         }
         if ( shifted > 122 ) {
            converted.push_back( static_cast<char>((shifted % 123 ) + 97 ) ) ;
         }
      }
   }
   return converted ;
}

int main( ) {
   std::cout << "Enter a word consisting of ASCII alphabetic characters only!\n" ;
   std::string word ;
   std::cin >> word ;
   std::cout << "Enter a positive integer!\n" ;
   int number ;
   std::cin >> number ;
   std::cout << convert( word , number ) << '\n' ;
}
