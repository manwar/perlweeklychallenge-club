#include <iostream>
#include <string>
#include <map>

int main( ) {
   std::cout << "Enter a word!\n" ;
   std::string firstWord ;
   std::cin >> firstWord ;
   std::cout << "Enter a second word, permuting the first one, plus one character!\n" ;
   std::string secondWord ;
   std::cin >> secondWord ;
   std::map<char , int> firstFreq ;
   std::map<char , int> secondFreq ;
   for ( auto c : firstWord ) 
      firstFreq[c]++ ;
   for ( auto c : secondWord )
      secondFreq[c]++ ;
   for ( auto c : secondWord ) {
      if ( firstWord.find( c ) == std::string::npos ) {
	 std::cout << c << '\n' ;
	 break ;
      }
      else {
	 auto it1 = firstFreq.find( c ) ;
	 auto it2 = secondFreq.find( c ) ;
	 if ( it1->second != it2->second ) {
	    std::cout << c << '\n' ;
	    break ;
	 }
      }
   }
   return 0 ;
}
