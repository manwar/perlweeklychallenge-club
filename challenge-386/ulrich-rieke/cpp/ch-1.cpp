#include <iostream>
#include <map>
#include <algorithm>
#include <string>

std::map<char , int> createTable( ) {
   std::map<int , char> conv_table ;
   for ( int i = 0 ; i < 10 ; i++ ) {
      conv_table[i] = static_cast<char>( i + 48 ) ;
   }
   for ( int i = 10 ; i < 36 ; i++ ) 
      conv_table[i] = static_cast<char>( i + 55 ) ;
   for ( int i = 36 ; i < 64 ; i++ ) 
      conv_table[i] = static_cast<char>( i + 61 ) ;
   conv_table[64] = '+' ;
   conv_table[65] = '/' ;
   std::map<char , int> result ;
   for ( auto p : conv_table ) 
      result[p.second] = p.first ;
   return result ;
}

int convert( std::string & numberstring , const int base , 
      const std::map<char , int> & table ) {
   int result = 0 ;
   int multiplier = 1 ;
   std::reverse( numberstring.begin( ) , numberstring.end( ) ) ;
   for ( char c : numberstring ) {
      auto found = std::find_if( table.begin( ) , table.end( ) , [c] (
        auto p ) { return p.first == c ; } ) ;
      int factor = multiplier * found->second ;
      result += factor ;
      multiplier *= base ;
   }
   return result ;
}

int main( ) {
   std::cout << "Enter a number string in a given base!\n" ;
   std::string numberstring ;
   std::cin >> numberstring ;
   std::cout << "Enter a base!\n" ;
   int base ;
   std::cin >> base ;
   auto table { createTable( ) } ;
   std::cout << convert( numberstring , base , table ) << '\n' ;
   return 0 ;
}
