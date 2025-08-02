#include <iostream> 
#include <numeric>
#include <string>
#include <vector>
#include <map>
#include <cstdlib>
#include <algorithm>

int main( ) {
   std::cout << "Enter a word with smallcase English letters only!\n" ;
   std::string word ;
   std::cin >> word ;
   std::vector<char> alphabet( 26 ) ;
   std::iota( alphabet.begin( ) , alphabet.end( ) , 'a' ) ;
   std::vector<int> taggers( 26 ) ;
   std::iota( taggers.begin( ) , taggers.end( ) , 1 ) ;
   std::map<char , int> taggedChars ;
   for ( int i = 0 ; i < 26 ; i++ ) {
      taggedChars[ alphabet[i] ] = taggers[i] ;
   }
   int seconds = 0 ;
   if ( word.substr( 0 , 1 ) != "a" ) {
      auto it = taggedChars.find( word[0] ) ;
      int number = it->second ;
      int onedir_diff = std::abs( number - 1 ) ;
      int otherdir_diff = 26 - onedir_diff ;
      int diff = std::min( onedir_diff , otherdir_diff ) ;
      seconds += diff ;
   }
   int len = word.length( ) ;
   for ( int pos = 0 ; pos < len - 1 ; pos++ ) {
      char firstChar = word[ pos ] ;
      char secondChar = word[ pos + 1 ] ;
      int firstNumber = taggedChars.find( firstChar )->second ;
      int secondNumber = taggedChars.find( secondChar )->second ;
      int onedir_diff = std::abs( firstNumber - secondNumber ) ;
      int otherdir_diff = 26 - onedir_diff ;
      int diff = std::min( onedir_diff , otherdir_diff ) ;
      seconds += diff ;
   }
   seconds += len ;
   std::cout << seconds << '\n' ;
   return 0 ;
}
