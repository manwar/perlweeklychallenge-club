#include <vector>
#include <iostream>
#include <sstream>
#include <string>

std::vector<std::string> split( const std::string & text , char delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr , word , delimiter ) ) 
      tokens.push_back( word ) ;
   return tokens ;
}

int main( ) {
   std::cout << "Enter some integers separated by whitespace!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   std::cout << "Enter number of rows and columns!\n" ;
   std::string dimline ;
   std::getline( std::cin , dimline ) ;
   std::vector<int> numbers , dimensions ;
   auto numbertokens { split( line , ' ' ) } ;
   auto dimtokens { split( dimline , ' ' ) } ;
   for ( auto s : numbertokens ) 
      numbers.push_back( std::stoi( s ) ) ;
   for ( auto s : dimtokens ) 
      dimensions.push_back( std::stoi( s )) ;
   if ( dimensions[0] * dimensions[1] != static_cast<int>(numbers.size( ) ) ) {
      std::cerr << "product of rows and columns must equal number of elts!\n" ;
      return 1 ;
   }
   else {
      int pos = 0 ;
      std::vector<std::vector<int>> myArray ;
      for ( int r = 0 ; r < dimensions[0] ; r++ ) {
	 std::vector<int> currentRow ;
	 for ( int c = 0 ; c < dimensions[1] ; c++ ) {
	    currentRow.push_back( numbers[pos] ) ;
	    pos++ ;
	 }
	 myArray.push_back( currentRow ) ;
      }
      std::cout << "( " ;
      for ( auto vec : myArray ) {
	 std::cout << "[ " ;
	 for ( auto it = vec.begin( ) ; it != vec.end( ) ; ++it ) {
	    std::cout << *it << ' ' ;
	 }
	 std::cout << "] " ;
      }
      std::cout << ") \n" ;
      return 0 ;
   }
}

