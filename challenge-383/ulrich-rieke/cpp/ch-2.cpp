#include <iostream>
#include <string> 
#include <map>
#include <algorithm>
#include <cstdlib>
#include <vector>

std::map<std::string , int> createConversion( ) {
   std::map<std::string , int> conversion ;
   for ( int i = 0 ; i < 10 ; i++ ) {
      conversion[std::to_string( i )] = i ;
   }
   int n = 10 ;
   const std::string helper {"ABCDEF"} ;
   for ( int i = 0 ; i < 6 ; i++ ) {
      conversion[helper.substr( i , 1 )] = n ;
      n++ ;
   }
   return conversion ;
}

std::string roundRGB( std::string color ) {
   std::string converted ;
   converted.push_back( '#' ) ;
   std::map<std::string , int> websafes {{"00" , 0} , {"33" , 51} , 
      {"66" , 102} , {"99" , 153} , {"CC" , 204} , {"FF" , 255}} ;
   std::map<int , std::string> hex_to_value ;
   for ( auto it = websafes.begin( ) ; it != websafes.end( ) ; ++it ) {
      hex_to_value[it->second] = it->first ;
   }
   std::string colorpart { color.substr( 1 ) } ;
   auto conversion { createConversion( ) } ;
   std::vector<int> values ; 
   for ( auto it = websafes.begin( ) ; it != websafes.end( ) ; ++it ) {
      values.push_back( it->second ) ;
   }
   for ( int i = 0 ; i < 3 ; i++ ) {
      std::string current_color { colorpart.substr( 2 * i , 2 ) } ;
      int number = conversion[current_color.substr( 0 , 1 )] * 16 + 
         conversion[current_color.substr( 1 , 1 )] ;
      std::sort( values.begin( ) , values.end( ) , [number]( int a , int b)
            { return std::abs( a - number ) < std::abs( b - number ) ; } ) ;
      converted += hex_to_value[*values.begin()] ;
   }
   return converted ;
}

int main( ) {
   std::cout << "Enter a RGB color!\n" ;
   std::string color ;
   std::cin >> color ;
   std::cout << roundRGB( color ) << '\n' ;
   return 0 ;
}
