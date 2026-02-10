#include <iostream>
#include <string>

int main( ) {
   std::cout << "Enter a word!\n" ;
   std::string word ;
   std::getline( std::cin , word ) ;
   std::cout << "Enter a width!\n" ;
   int width ;
   std::cin >> width ;
   int len = static_cast<int>( word.length( ) ) ;
   std::string output ;
   if ( len == 0 ) {
      for ( int i = 0 ; i < width ; i++ ) {
         output.push_back( '*' ) ;
      }
   }
   else {
      int left = (width - len) / 2 ;
      for ( int i = 0 ; i < left ; i++ ) 
         output.push_back( '*' ) ;
      output.append( word ) ;
      for ( int i = 0 ; i < width - len - left ; i++ )
         output.push_back( '*' ) ;
   }
   std::cout << output << '\n' ;
   return 0 ;
}
