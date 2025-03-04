#include <iostream>
#include <string>
#include <vector>

int digitsum( const std::string & number ) {
   int sum = 0 ;
   for ( int i = 0 ; i < number.length( ) ; i++ ) {
      sum += std::stoi( number.substr( i , 1 ) ) ;
   }
   return sum ;
}

std::vector<std::string> chop( const std::string & text , int size ) {
   std::vector<std::string> parts ;
   int len = text.length( ) ;
   int pos = 0 ;
   while ( pos < len ) {
      parts.push_back( text.substr( pos , size ) ) ;
      pos += size ;
   }
   int used_so_far = parts.size( ) * size ;
   if ( used_so_far < len ) 
      parts.push_back( text.substr( used_so_far ) ) ;
   return parts ;
}

int main( ) {
   std::cout << "Enter a string consisting of digits only!\n" ;
   std::string numberstring ;
   std::cin >> numberstring ;
   std::cout << "Enter a number less than the length of the string!\n" ;
   int chunksize ;
   std::cin >> chunksize ;
   auto parts { chop( numberstring , chunksize ) } ;
   int sum = 0 ;
   std::string sumstring ;
   for ( auto p : parts ) {
      sum = digitsum( p ) ;
      sumstring += std::to_string( sum ) ;
   }
   while ( sumstring.length( ) > chunksize ) {
      parts = chop( sumstring , chunksize ) ;
      sumstring.clear( ) ;
      for ( auto p : parts ) {
	 sum = digitsum( p ) ;
	 sumstring += std::to_string( sum ) ;
      }
   }
   std::cout << sumstring << '\n' ;
   return 0 ;
}
