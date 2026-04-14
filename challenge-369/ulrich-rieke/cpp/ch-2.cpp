#include <iostream>
#include <string>
#include <vector>
#include <sstream>

std::vector<std::string> split( const std::string & text , const char 
      delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr , word , delimiter ) ) 
      tokens.push_back( word ) ;
   return tokens ;
}

int main( ) {
   std::cout << "Enter a string , a size and a filler separated by blanks!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens { split( line , ' ' ) } ;
   std::string myString { tokens[0] } ;
   int size { std::stoi( tokens[1] ) } ;
   char filler { tokens[2][0] } ;
   int len = myString.length( ) ;
   int start = 0 ;
   std::vector<std::string> output ;
   while ( start < len ) {
      if ( start + size < len ) {
         output.push_back( myString.substr( start , size )) ;
      }
      else 
         output.push_back( myString.substr( start )) ;
      start += size ;
   }
   std::string last_word = output.back( ) ;
   int ll = last_word.length( ) ;
   if ( ll < size ) {
      for ( int i = 0 ; i < size - ll ; i++ ) {
         last_word.push_back( filler ) ;
      }
      output.pop_back( ) ;
      output.push_back( last_word ) ;
   }
   std::cout << "( " ;
   for ( auto s : output ) 
      std::cout << s << ' ' ;
   std::cout << ")\n" ;
   return 0 ;
}
