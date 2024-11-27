#include <iostream>
#include <algorithm>
#include <string>
#include <vector>
#include <sstream>

std::vector<std::string> split( const std::string & text , char delim ) {
   std::istringstream istr { text } ;
   std::vector<std::string> tokens ;
   std::string word ;
   while ( std::getline( istr , word , delim ) ) {
      tokens.push_back( word ) ;
   }
   return tokens ;
}

void printVector( const std::vector<int> & selected ) {
   std::cout << "( ";
   for ( int i : selected ) {
      std::cout << i << ' ' ;
   }
   std::cout << ')' ;
}

int main( ) {
   std::cout << "Enter some integers, separated by blanks!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   std::vector<int> numbers ;
   auto numberstrings { split( line , ' ' ) } ;
   for ( auto s : numberstrings ) 
      numbers.push_back( std::stoi( s ) ) ;
   std::vector<int> myCopy( numbers ) ;
   std::sort( myCopy.begin( ) , myCopy.end( ) ) ;
   std::vector<std::vector<int>> allPermus ;
   allPermus.push_back( myCopy ) ;
   while ( std::next_permutation( myCopy.begin( ) , myCopy.end( ) ) ) {
      allPermus.push_back( myCopy ) ;
   }
   auto pos = std::find( allPermus.begin( ) , allPermus.end( ) , 
	 numbers ) ;
   if ( *pos == allPermus.back( ) ) {
      printVector( allPermus.front( ) ) ;
   }
   else {
      printVector( *(pos + 1 ) ) ;
   }
   std::cout << '\n' ;
   return 0 ;
}
