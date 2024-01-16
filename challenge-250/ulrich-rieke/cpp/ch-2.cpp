#include <vector>
#include <iostream>
#include <string>
#include <algorithm>
#include <cctype>

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

int convert( const std::string & s ) {
   if ( std::any_of( s.begin( ) , s.end( ) , []( auto c ){ return 
	    std::isalpha( c ) ; } ) ) {
      return s.length( ) ;
   }
   else {
      return std::stoi( s ) ;
   }
}

int main( ) {
   std::cout << "Please enter some strings, separated by blanks!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   std::vector<std::string> allStrings { split( line , " " ) } ;
   std::vector<int> nums ( allStrings.size( ) ) ;
   std::transform( allStrings.begin( ) , allStrings.end( ) , 
	 nums.begin( ) , convert ) ;
   std::cout << *std::max_element( nums.begin( ) , nums.end( )) <<
	 std::endl ;
   return 0 ;
}
	 

