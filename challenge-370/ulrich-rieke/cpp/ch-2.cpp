#include <iostream>
#include <string>
#include <sstream>
#include <vector>
#include <algorithm>

std::vector<std::string> split( const std::string & text , const char
      delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr , word , delimiter ) ) 
      tokens.push_back( word ) ;
   return tokens ;
}

//two words are anagrams if their sorted letter sequences are the same
bool areAnagrams( std::string firstWord , std::string secondWord ) {
   std::sort( firstWord.begin( ) , firstWord.end( ) ) ;
   std::sort( secondWord.begin( ) , secondWord.end( ) ) ;
   return firstWord == secondWord ;
}

//two words are scrambled in the sense of the task if there exists at
//least one split point where the front and rear parts of both strings 
//are anagrams , or the front part of one and the rear part of the other
bool areScrambled( std::string firstWord , std::string secondWord ) {
   int len = firstWord.length( ) ;
   for ( int i = 1 ; i < len - 1 ; i++ ) {
      if (( areAnagrams( firstWord.substr( 0 , i ) , secondWord.substr(0 , i ))        && areAnagrams( firstWord.substr( i ) , secondWord.substr( i ) )) ||
        ( areAnagrams( firstWord.substr( i ) , secondWord.substr( 0 , i )) &&
          areAnagrams( firstWord.substr( 0 , i ) , secondWord.substr( i )))) {
         return true ;
      }
   }
   return false ;
}

int main( ) {
   std::cout << "Enter two strings with equal length!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens { split( line , ' ' ) } ;
   std::cout << std::boolalpha << areScrambled( tokens[0] , tokens[1] ) << '\n' ;
   return 0 ;
}

