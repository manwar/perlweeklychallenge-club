#include <iostream>
#include <vector>
#include <sstream>
#include <string>

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
   std::cout << "Enter some words separated by whitespace!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens { split( line , ' ' ) } ;
   std::cout << "Enter a sentence!\n" ;
   std::string sentence ;
   std::getline( std::cin , sentence ) ;
   auto sentencewords { split( sentence , ' ' ) } ;
   std::string changedsentence ;
   for ( auto s : sentencewords ) {
      bool changed = false ;
      for ( auto w : tokens ) {
	 auto wsize = w.length( ) ;
	 if ( s.substr(0 , wsize ) == w ) {
	    changedsentence.append( w ) ;
	    changed = true ;
	 }
      }
      if (! changed ) {
	 changedsentence.append( s  );
      }
      changedsentence.append( " " ) ;
   }
   std::cout << changedsentence << '\n' ;
}
