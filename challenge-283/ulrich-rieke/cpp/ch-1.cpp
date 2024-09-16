#include <iostream>
#include <vector>
#include <string>
#include <map>
#include <sstream>

std::vector<std::string> split( std::string text , const char delimiter ) {
   std::stringstream instr { text } ;
   std::string word ;
   std::vector<std::string> tokens ;
   while ( std::getline( instr , word , delimiter )) 
      tokens.push_back( word ) ;
   return tokens ;
}

int main( ) {
   std::cout << "Enter some integers several times , one only once!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens { split( line, ' ' ) } ;
   std::vector<int> numbers ;
   for ( auto s : tokens ) 
      numbers.push_back( std::stoi( s ) ) ;
   std::map<int , int> frequencies ;
   for ( int i : numbers ) 
      frequencies[i]++ ;
   for ( auto it = frequencies.begin( ) ; it != frequencies.end( ) ; ++it ) {
      if ( it->second == 1 ) {
	 std::cout << it->first << '\n' ;
      }
   }
   return 0 ;
}
