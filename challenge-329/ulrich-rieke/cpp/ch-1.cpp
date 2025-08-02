#include <string>
#include <vector>
#include <regex>
#include <iostream>
#include <set>
using namespace std::string_literals ;

int main( ) {
   std::cout << "Enter a word with lowercase English letters and digits!\n" ;
   std::string word ;
   std::cin >> word ;
   auto rx = std::regex( R"((\d+))"s ) ;
   std::vector<std::string> numberstrings ;
   auto end = std::sregex_token_iterator {} ;
   for ( auto it = std::sregex_token_iterator(std::begin( word ) , 
	    std::end( word ) , rx ) ; it != end ; ++it ) {
      numberstrings.push_back( *it ) ;
   }
   std::vector<int> numbers ;
   for ( auto s : numberstrings ) 
      numbers.push_back( std::stoi( s ) ) ;
   std::set<int> uniques { numbers.begin( ) , numbers.end( ) } ;
   std::vector<int> solution ;
   for ( int n : numbers ) {
      if ( uniques.contains( n ) ) {
	 solution.push_back( n ) ;
	 uniques.erase( uniques.find( n ) ) ;
      }
   }
   for ( int n : solution ) {
      std::cout << n << ' ' ;
   }
   std::cout << '\n' ;
   return 0 ;
}
