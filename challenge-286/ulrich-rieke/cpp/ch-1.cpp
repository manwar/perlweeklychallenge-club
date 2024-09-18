#include <vector>
#include <string>
#include <sstream>
#include <fstream>
#include <random>
#include <iostream>

std::vector<std::string> split( const std::string & text , 
      const char delimiter ) {
   std::istringstream istr { text } ;
   std::vector<std::string> tokens ;
   std::string word ;
   while ( std::getline( istr , word , delimiter ) ) {
      if ( word.length( ) > 0 ) {
	 tokens.push_back( word ) ;
      }
   }
   return tokens ;
}

int main( ) {
   std::ifstream infile( "challenge286.cpp" ) ;
   std::vector<std::string> allWords ;
   if ( infile.is_open( ) ) {
      std::string line ;
      while ( infile ) {
	 std::getline( infile , line ) ;
	 if ( ! line.empty( ) ) {
	    std::vector<std::string> tokens { split( line , ' ' ) } ;
	    for ( auto s : tokens ) 
	       allWords.push_back( s ) ;
	 }
      }
   }
   infile.close( ) ;
   int len = allWords.size( ) ;
   std::random_device rd ;
   std::mt19937 gen( rd( ) ) ;
   std::uniform_int_distribution<> distri(0 , len - 1 ) ;
   int pos = distri( gen ) ;
   std::cout << allWords[pos] << '\n' ;
   return 0 ;
}
