#include <string>
#include <iostream>

int main( ) {
   std::cout << "Enter a string!\n" ;
   std::string word ;
   std::cin >> word ;
   int value = 0 ;
   int pos = 1 ;
   for ( char letter : word ) {
      value += pos * ( 123 - static_cast<int>( letter ) ) ;
      pos++ ;
   }
   std::cout << value << '\n' ;
   return 0 ;
}
