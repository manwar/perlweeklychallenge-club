#include <iostream>
#include <list>
#include <string>

std::list<std::string> split( const std::string & startline ,
      const std::string & sep ) {
   std::list<std::string> separated ;
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
   std::cout << "Enter some integers, separated by blanks!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   std::list<std::string> numberlist { split( line , " " ) } ;
   int sum = 0 ;
   while ( numberlist.size( ) > 0 ) {
      if ( numberlist.size( ) > 1 ) {
	 std::string concatenated { numberlist.front( ).append( 
	       numberlist.back( )) } ;
	 sum += std::stoi( concatenated ) ;
	 numberlist.pop_front( ) ;
	 numberlist.pop_back( ) ;
      }
      else {
	 sum += std::stoi( numberlist.front( ) ) ;
	 numberlist.pop_front( ) ;
      }
   }
   std::cout << sum << '\n' ;
   return 0 ;
}
