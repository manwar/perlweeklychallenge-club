#include <vector>
#include <string>
#include <iostream>
#include <ranges>

std::vector<std::string> split( const std::string & startline ,
      const std::string & sep ) {
   std::vector<std::string> separated ;
   std::string::size_type start { 0 } ;
   std::string::size_type pos ;
   do {
      pos = startline.find_first_of( sep , start ) ;
      separated.push_back( startline.substr(start , pos - start )) ;
      start = pos + 1 ;
   } while ( pos != std::string::npos ) ;
   return separated ;
}

int main( ) {
   std::cout << "Enter some tickets in the given format!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   std::vector<std::string> tickets( split ( line , " " ) ) ;
   auto cond = []( std::string s ) { return std::stoi( s.substr( 11 , 2 ) ) 
      >= 60 ; } ;
   std::vector<std::string> result ;
   for ( auto s :  tickets | std::views::filter( cond ) ) 
      result.push_back( s ) ;
   std::cout << result.size( ) << std::endl ;
   return 0 ;
}
