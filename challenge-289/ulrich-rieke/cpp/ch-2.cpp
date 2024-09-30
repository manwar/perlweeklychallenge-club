#include <vector>
#include <string>
#include <random>
#include <iostream> 
#include <sstream>
#include <algorithm>

std::vector<std::string> split( std::string & text , char delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr , word , delimiter ) ) {
      tokens.push_back( word ) ;
   }
   return tokens ;
}

std::string do_shuffle( const std::string & word ) {
   std::random_device rd ;
   std::mt19937 g ( rd( ) ) ;
   std::string central { word.substr( 1 , word.length( ) - 2 ) } ;
   std::string output { word.substr( 0 , 1 ) } ;
   std::shuffle( central.begin( ) , central.end( ) , g ) ;
   output = output + central ;
   output.push_back( word.back( ) ) ;
   return output ;
}

int main( ) {
   std::cout << "Enter some sentences, <return> to end!\n" ;
   std::vector<std::string> block ;
   std::string line ;
   std::getline( std::cin , line ) ;
   while ( ! line.empty( ) ) {
      block.push_back( line ) ;
      std::getline( std::cin , line ) ;
   }
   std::vector<std::string> shuffled ;
   for ( auto aLine : block ) {
      std::vector<std::string> shuffled_line ;
      auto tokens { split( aLine , ' ' ) } ;
      for ( auto w : tokens ) {
	 if ( w.length( ) <= 3 ) {
	    shuffled_line.push_back( w ) ;
	 }
	 else {
	    shuffled_line.push_back( do_shuffle( w ) ) ;
	 }
      }
      std::string changed ;
      for ( auto w : shuffled_line ) {
	 changed = changed + w + " " ;
      }
      changed.pop_back( ) ;
      shuffled.push_back( changed ) ;
   }
   for ( auto w : shuffled ) {
      std::cout << w << '\n' ;
   }
   return 0 ;
}



