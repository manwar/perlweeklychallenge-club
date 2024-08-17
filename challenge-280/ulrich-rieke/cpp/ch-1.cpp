#include <iostream>
#include <string>
#include <map>

int main( ) {
   std::cout << "Enter a word with lowercase English letters only!\n" ;
   std::string word ;
   std::cin >> word ;
   std::map<char , int> frequencies ;
   char result {' '} ;
   for ( int i = 0 ; i < word.length( ) ; i++ ) {
      char c = word[i] ;
      frequencies[c]++ ;
      if (frequencies.find( c )->second == 2) {
	 result = c ;
	 break ;
      }
   }
   std::cout << result << '\n' ;
   return 0 ;
}
