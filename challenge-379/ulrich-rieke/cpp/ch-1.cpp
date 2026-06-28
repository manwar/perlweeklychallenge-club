#include <iostream>
#include <string>

int main( ) {
   std::cout << "Enter a word!\n" ;
   std::string word ;
   std::getline( std::cin , word ) ;
   int current = static_cast<int>( word.length( ) ) ;
   if ( current == 0 ) 
      std::cout << "\"\"" << '\n' ;
   else {
      std::string reversed ;
      current-- ;
      while ( current != -1 ) {
         reversed += word.substr( current , 1 ) ;
         current-- ;
      }
      std::cout << reversed << '\n' ;
   }
   return 0 ;
}
