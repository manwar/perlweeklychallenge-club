#include <vector>
#include <iostream>
#include <algorithm>
#include <numeric>
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
   std::cout << "Enter some integers, separated by blanks, e to end!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   std::vector<int> numbers ;
   std::vector<std::string> numberlines { split( line, " " ) } ;
   for ( auto s : numberlines ) 
      numbers.push_back( std::stoi( s ) ) ;
   std::cout << "Enter an integer x for one-level operation!\n" ;
   int x ;
   std::cin >> x ;
   std::cout << " and an y for two-level operations!\n" ;
   int y ;
   std::cin >> y ;
   int comp = numbers[0] ;
   if ( std::all_of( numbers.begin( ) , numbers.end( ) , [comp]( int i ) { 
	    return i == comp ; } ) ) 
      std::cout << 0 << '\n' ;
   else {
      int maximum = *std::max_element( numbers.begin( ) , numbers.end( ) ) ;
      std::vector<int> smaller ;
      for ( int i : numbers ) {
	 if ( i < maximum ) 
	    smaller.push_back( i ) ;
      }
      std::transform( smaller.begin( ) , smaller.end( ) , smaller.begin( ) , [maximum](
	       int i ) { return maximum - i ; } ) ;
      int total_diff = std::accumulate( smaller.begin( ) , smaller.end( ) , 0 ) ;
      if ( smaller.size( ) == 1 ) 
	 std::cout << total_diff * x << '\n' ;
      else {
	 std::vector<int> costs ;
	 for ( int twos = 0 ; twos < total_diff / 2 + 1 ; twos++ ) {
	    int ones = total_diff - twos * 2 ;
	    costs.push_back( ones * x + twos * y ) ;
	 }
	 std::cout << *std::min_element( costs.begin( ) , costs.end( ) ) << '\n' ;
      }
   }
   return 0 ;
}
