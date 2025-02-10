#include <iostream>
#include <string>
#include <sstream>
#include <vector>

std::vector<std::string> split( const std::string & text , char delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr , word , delimiter ) ) {
      tokens.push_back( word ) ;
   }
   return tokens ;
}

int main( ) {
   std::cout << "Enter some numbers separated by whitespace!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens { split( line , ' ' ) } ;
   std::vector<int> encoded ;
   for ( auto s : tokens ) 
      encoded.push_back( std::stoi( s ) ) ;
   std::cout << "Enter an initial integer!\n" ;
   int initial ;
   std::cin >> initial ;
   std::vector<int> decoded ;
   decoded.push_back( initial ) ;
   //to find x in a xor x = b you can do a xor b since xor is its own 
   //inverse function!
   for ( auto it = encoded.begin( ) ; it != encoded.end( ) ; ++it ) {
      int last = decoded[decoded.size( ) - 1] ;
      decoded.push_back( last ^ *it ) ;
   }
   std::cout << "( " ;
   for ( int i : decoded ) {
      std::cout << i << ' ' ;
   }
   std::cout << ")\n" ;
   return 0 ;
}

