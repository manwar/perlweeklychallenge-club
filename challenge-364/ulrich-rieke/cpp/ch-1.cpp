#include <iostream>
#include <string>
#include <map>

std::string  convert( std::string text , const std::map<std::string , std::string> &
      conversions ) {
   auto found = text.find( "#") ;
   while ( found != std::string::npos ) {
      std::string to_be_replaced { text.substr( found - 2 , 3 ) } ;
      std::string replacement { conversions.find( to_be_replaced )->second } ;
      text.replace( found - 2 , 3 , replacement ) ;
      found = text.find( "#" ) ;
   }
   found = text.find_first_of( "123456789" ) ;
   while ( found != std::string::npos ) {
      std::string to_be_replaced { text.substr( found , 1 ) } ;
      std::string replacement { conversions.find( to_be_replaced )->second } ;
      text.replace( found , 1 , replacement ) ;
      found = text.find_first_of( "123456789" ) ;
   }
   return text ;
}

int main( ) {
   std::map<std::string , std::string> mappings ;
   std::string lowerletters {"abcdefghi"} ;
   std::string upperletters {"jklmnopqrstuvwxyz"} ;
   for ( int i = 0 ; i < lowerletters.length( ) ; i++ ) {
      mappings[std::to_string( i + 1 )] = lowerletters.substr( i , 1 ) ;
   }
   for ( int i = 0 ; i < upperletters.length( ) ; i++ ) {
      mappings[std::to_string( i + 10 ) += "#"] = upperletters.substr( i , 1 ) ;
   }
   std::cout << convert( "10#11#12" , mappings ) << '\n' ;
   std::cout << convert( "1326#" , mappings ) << '\n' ;
   std::cout << convert( "25#24#123" , mappings ) << '\n' ;
   std::cout << convert( "20#5" , mappings ) << '\n' ;
   std::cout << convert( "1910#26#" , mappings ) << '\n' ;
   return 0 ;
}
