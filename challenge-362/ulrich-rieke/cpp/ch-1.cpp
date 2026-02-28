#include <iostream>
#include <string>

int main( ) {
   std::cout << "Enter a word!\n" ;
   std::string word ;
   std::cin >> word ;
   int howmany = 1 ;
   std::string result ;
   for ( auto it = word.begin( ) ; it != word.end( ) ; ++it ) {
      result.append( howmany , *it) ;
      howmany++ ;
   }
   std::cout << result << '\n' ;
   return 0 ;
}
