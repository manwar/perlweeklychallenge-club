#include <vector>
#include <iostream>
#include <string>
#include <algorithm>
#include <utility>

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
   std::cout << "Enter some computer languages, separated by blanks!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   std::vector<std::string> languages( split( line , " " ) ) ;
   std::cout << "Enter some popularity indices, separated by blanks!\n" ;
   std::getline( std::cin , line ) ;
   std::vector<std::string> pops ( split( line , " " ) ) ;
   std::vector<int> popularities ;
   for ( auto s : pops ) 
      popularities.push_back( std::stoi( s ) ) ;
   int len = languages.size( ) ;
   std::vector<std::pair<int , std::string>> pop_pairs ;
   for ( int i = 0 ; i < len ; i++ ) {
      pop_pairs.push_back( std::make_pair( popularities[ i ] , languages[ i ] ) ) ;
   }
   std::sort( pop_pairs.begin( ) , pop_pairs.end( ) , []( const auto & p1 ,
	    const auto & p2 ) { return p1.first < p2.first ; } ) ;
   std::cout << "(" ;
   for ( const auto & p : pop_pairs ) {
      std::cout << p.second ;
      if ( p != pop_pairs.back( ) ) {
	 std::cout << "," ;
      }
   }
   std::cout << ")\n" ;
   return 0 ;
}
