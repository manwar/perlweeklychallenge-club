#include <vector>
#include <string>
#include <sstream>
#include <iostream>

std::vector<std::string> split( const std::string & text , char delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr , word , delimiter ) )
      tokens.push_back( word ) ;
   return tokens ;
}

int main( ) {
   std::cout << "Enter a string and a positive number!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens { split( line , ' ' ) } ;
   std::string word { tokens[0] } ;
   auto it = word.find( "-" ) ;
   while ( it != std::string::npos ) {
      word.erase( it , 1 ) ;
      it = word.find( "-" ) ;
   }
   int number { std::stoi( tokens[1] ) } ;
   std::string solution ;
   int wordlen = static_cast<int>( word.length( ) )  ;
   int firstlen = wordlen % number ;
   int pos = 0 ;
   if ( firstlen != 0 ) {
      solution = word.substr( 0 , firstlen ) ;
      solution.push_back( '-' ) ;
      pos = firstlen ;
   }
   while ( pos + number < wordlen ) {
      solution += word.substr( pos , number ) ;
      solution.push_back( '-' ) ;
      pos += number ;
   }
   solution += word.substr( pos ) ;
   std::cout << solution << '\n' ;
   return 0 ;
}
