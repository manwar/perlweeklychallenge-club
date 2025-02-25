#include <vector> 
#include <string> 
#include <iostream> 
#include <sstream> 
#include <algorithm> 
#include <map> 
#include <numeric>

std::vector<std::string> split( const std::string & text , char delim ) {
   std::istringstream istr { text } ;
   std::vector<std::string> tokens ;
   std::string word ;
   while ( std::getline( istr , word , delim ) ) {
      tokens.push_back( word ) ;
   }
   return tokens ;
}

int main( ) {
   std::cout << "Enter some positive integers separated by whitespace!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens { split( line , ' ' ) } ;
   std::vector<int> numbers ;
   for ( auto s : tokens )
      numbers.push_back( std::stoi( s ) ) ;
   if ( numbers.size( ) < 4 ) {
      std::cout << "false" << '\n' ;
   }
   else {
      if ( numbers.size( ) == 4 ) {
	 int start = *numbers.begin( ) ;
	 std::cout << std::boolalpha << std::all_of( numbers.begin( ) , 
	       numbers.end( ) , [start]( const int i ) { return i == 
	       start ; } ) << '\n' ;
      }
      else {
	 int sum = std::accumulate( numbers.begin( ) , numbers.end( ) , 0 ) ;
	 if ( sum % 4 != 0 ) {
	    std::cout << "false\n" ;
	 }
	 else {
	    std::map<int , int> frequencies ;
	    for ( int i : numbers ) 
	       frequencies[i]++ ;
	    int maxi = *std::max_element( numbers.begin( ) , numbers.end( ) ) ;
	    int maxfreq = frequencies.find( maxi )->second ;
	    int maxsum = ( 4 - maxfreq ) * maxi ;
	    int restsum = 0 ;
	    for ( auto it = frequencies.begin( ) ; it != frequencies.end( ) ; 
		  it++ ) {
	       if ( it->first != maxi ) {
		  restsum += it->second * it->first ;
	       }
	    }
	    std::cout << std::boolalpha << ( maxsum == restsum ) << '\n' ;
	 }
      }
   }
   return 0 ;
}
