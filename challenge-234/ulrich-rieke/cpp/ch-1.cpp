#include <iostream>
#include <algorithm>
#include <string>
#include <vector>
#include <map>

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
   std::cout << "Enter some words, separated by spaces!\n";
   std::string line ;
   std::getline( std::cin , line ) ;
   std::vector<std::string> words( split( line , " " ) ) ;
   std::map<char , int> frequencies ;
   for ( char c : *(words.begin( ) )) 
      frequencies[c]++ ;
   for ( auto it = frequencies.begin( ) ; it != frequencies.end( ) ; it++ ) {
      char letter = it->first ;
      for ( auto it = words.begin( ) + 1 ; it != words.end( ) ; it++ ) {
	 std::string word( *it ) ;
	 int howmany = std::count( word.begin( ) , word.end( ) , letter ) ;
	 if ( howmany < frequencies[letter] ) 
	    frequencies[letter] = howmany ;
      }
   }
   std::vector<char> result ;
   for ( const auto & p : frequencies ) {
      int num = p.second ;
      if ( num != 0 ) {
	 for ( int i = 0 ; i < num  ; i++ ) {
	    result.push_back( p.first ) ;
	 }
      }
   }
   std::cout << "( " ;
   for ( char c : result ) 
      std::cout << c << " " ;
   std::cout << " )" << std::endl ;
   return 0 ;
}
