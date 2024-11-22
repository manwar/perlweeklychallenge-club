#include <iostream>
#include <string> 
#include <vector>
#include <algorithm>
#include <regex>

std::string compress( const std::string & word ) {
   std::vector<std::string> terms ;
   std::string current ;
   int len = word.length( ) ;
   std::string firstStr { word.substr( 0 , 1 ) } ;
   current += firstStr ;
   for ( int i = 1 ; i < len ; i++ ) {
      std::string next { word.substr( i , 1 ) } ;
      if ( firstStr == next ) {
	 current += next ;
      }
      else {
	 terms.push_back( current ) ;
	 current = next ;
	 firstStr = next ;
      }
   }
   terms.push_back( current ) ;
   std::string compressed ;
   for ( auto s : terms ) {
      int l = s.length( ) ;
      if ( l > 1 ) {
	 compressed += std::to_string( l ) ;
	 compressed += s.substr( 0 , 1 ) ;
      }
      else {
	 compressed += s.substr( 0 , 1 ) ;
      }
   }
   return compressed ;
}

std::string decompress( const std::string & word ) {
   int len = word.length( )  ;
   std::string decompressed ;
   int pos = 0 ;
   std::string rgx {"\\d"} ;
   std::regex isNumber { rgx } ;
   while ( pos != len ) {
      std::string firstStr { word.substr( pos , 1 ) } ;
      if ( std::regex_match( firstStr , isNumber ) ) {
	 pos++ ;
	 std::string next { word.substr( pos , 1 ) } ;
	 for ( int i = 0 ; i < std::stoi( firstStr ) ; i++ ) {
	    decompressed += next ;
	 }
      }
      else {
	 decompressed += firstStr ;
      }
      pos++ ;
   }
   return decompressed ;
}

int main( ) {
   std::cout << "Enter a word!\n" ;
   std::string word ;
   std::cin >> word ;
   std::string compressed { compress( word ) } ;
   std::string decompressed { decompress( compressed ) } ;
   std::cout << word << " is compressed : " << compressed << " !\n" ;
   std::cout << "and decompressed : " << decompressed << '\n' ;
   return 0 ;
}

