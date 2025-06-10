#include <iostream>
#include <sstream>
#include <string>
#include <vector>
#include <iterator>
#include <algorithm>

std::vector<std::string> split( const std::string & text , char delimiter ) {
   std::vector<std::string> tokens ;
   std::string word ;
   std::istringstream istr { text } ;
   while ( std::getline( istr , word , delimiter ))
      tokens.push_back( word ) ;
   return tokens ;
}

int main( ) {
   std::cout << "Enter some prices separated by blanks!\n" ;
   std::string priceline ;
   std::getline( std::cin , priceline ) ;
   auto tokens { split( priceline , ' ' ) } ;
   std::vector<int> numbers , solution ;
   for ( auto s : tokens ) 
      numbers.push_back( std::stoi( s ) ) ;
   int len = numbers.size( ) ;
   for ( int i = 0 ; i < len - 1 ; i++ ) {
      std::vector<int> followers ;
      for ( int c = i + 1 ; c < len ; c++ ) {
	 if ( numbers[c] <= numbers[i] ) 
	    followers.push_back( numbers[c] ) ;
      }
      if ( followers.size( ) > 0 ) {
	 solution.push_back( numbers[i] - followers[0] ) ;
      }
      else {
	 solution.push_back( numbers[i] ) ;
      }
   }
   solution.push_back( numbers[len - 1] ) ;
   std::cout << "( ";
   std::copy( solution.begin( ) , solution.end( ) ,
	 std::ostream_iterator<int>( std::cout , " " ) ) ;
   std::cout << ")\n" ;
   return 0 ;
}
