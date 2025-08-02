#include <iostream>
#include <string>
#include <vector>
#include <sstream>

std::vector<std::string> split( const std::string & text , char delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr , word , delimiter ) ) 
      tokens.push_back( word ) ;
   return tokens ;
}

std::string reduceStr( std::string word ) {
   auto it = word.find( "#" ) ;
   while ( it != std::string::npos ) {
      word = word.erase( --it , 2 ) ;
      it = word.find( "#" ) ;
   }
   return word ;
}

int main( ) {
   std::cout << "Enter 2 words witz zero or more #!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens { split( line , ' ' ) } ;
   std::cout << std::boolalpha << ( reduceStr( tokens[0] ) == 
	 reduceStr( tokens[1] ) ) << '\n' ;
   return 0 ;
}
