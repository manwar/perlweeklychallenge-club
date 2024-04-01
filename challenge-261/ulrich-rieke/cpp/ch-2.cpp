#include <iostream>
#include <vector>
#include <algorithm>
#include <string>

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
   std::cout << "Enter some integers, separated by blanks!\n" ;
   std::string numberline ;
   std::getline( std::cin , numberline ) ;
   std::vector<std::string> innumbers { split( numberline , " " ) } ;
   std::vector<int> numbers ;
   for ( auto w : innumbers ) 
      numbers.push_back( std::stoi( w ) ) ;
   std::cout << "Enter a start number!\n" ;
   int start ;
   std::cin >> start ;
   while ( std::find( numbers.begin( ) , numbers.end( ) , start ) != 
	 numbers.end( ) ) 
      start *= 2 ;
   std::cout << start << '\n' ;
   return 0 ;
}
