#include <vector>
#include <iostream>
#include <sstream>
#include <string>

std::vector<std::string> split( const std::string & text , char delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr , word , delimiter ) ) {
      tokens.push_back( word ) ;
   }
   return tokens ;
}

int main( ) {
   std::cout << "Enter some strings separated by whitespace!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens { split( line , ' ' ) } ;
   std::cout << "Enter another word!\n" ;
   std::string comparison ;
   std::cin >> comparison ;
   std::string firstletters ;
   for ( auto w : tokens ) {
      firstletters.push_back( w[0] ) ;
   }
   std::cout << std::boolalpha << ( firstletters == comparison ) << '\n' ;
   return 0 ;
}
